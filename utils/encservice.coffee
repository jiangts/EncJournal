EncLayer = require './enclayer'
FSLayer = require './fslayer'
path = require 'path'

# High level APIs to be called by enc-cli and the web app
class EncService
  constructor: (@rootDir, @promptPasscode) ->
    @fs = new FSLayer(@rootDir)
    @enc = new EncLayer(@rootDir)
    @clearPasscode()
    # TODO remove
    @passcode = 'testsecret'

  # session length is in minutes
  setPasscode: (@passcode, sessionLength = 1000 * 60 * 10) ->
    now = new Date()
    @expireDate = new Date()
    @expireDate.setTime(now.getTime() + sessionLength)
    now = null

  checkValidPasscode: () ->
    if not @passcode? or new Date() > @expireDate
      @clearPasscode()
      @promptPasscode()
      return false
    return true

  clearPasscode: ->
    @passcode = null

  listEncFiles: (dirpath, callback) ->
    @checkValidPasscode()
    @fs.listFiles(dirpath, (error, data) =>
      for file, i in data
        if path.extname file is '.enc'
          data[i] = @enc.decrypt(text, @passcode, 'hex')
      callback(error, data)
    )

  createEncFile: (dirpath, filename, content) ->
    @checkValidPasscode()
    filename = @enc.encrypt(filename, @passcode, 'hex') + '.enc'
    content = @enc.encrypt(content, @passcode)
    @fs.createFile(path.join(dirpath, filename), content)

  readEncFile: (dirpath, filename, callback) ->
    @checkValidPasscode()
    @fs.readFile(path.join(dirpath, filename), (error, data) =>
      throw error if error
      data = @enc.decrypt(data, @passcode)
      callback(error, data)
    )

  updateEncFile: (dirpath, filename, content) ->
    @checkValidPasscode()
    @fs.updateFile(path.join dirpath, filename, content)

# name files, but encrypt them at same time

###
run file. prompt for passcode.
if works, let user list files.
let user choose existing file to be added to encrypted repo.
let user unencrypt a file into plain text.
###

module.exports = EncService
