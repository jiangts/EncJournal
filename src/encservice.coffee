EncLayer = require './enclayer'
FSLayer = require './fslayer'
path = require 'path'

# High level APIs to be called by enc-cli and the web app
class EncService
  constructor: (@rootDir) ->
    @fs = new FSLayer(@rootDir)
    @enc = new EncLayer(@rootDir)

  listEncFiles: (dirpath, callback, passcode) ->
    @fs.listFiles(dirpath, (err, data) =>
      for file, i in data
        if path.extname file is '.enc'
          data[i] = @enc.decrypt(text, passcode, 'hex')
      callback(err, data)
    )

  createEncFile: (dirpath, filename, content, passcode) ->
    filename = @enc.encrypt(filename, passcode, 'hex') + '.enc'
    content = @enc.encrypt(content, passcode)
    @fs.createFile(path.join(dirpath, filename), content)

  readEncFile: (dirpath, filename, callback, passcode) ->
    @fs.readFile(path.join(dirpath, filename), (err, data) =>
      if err then return callback(err, null, null)
      data = @enc.decrypt(data, passcode)
      filename = @enc.decrypt(filename, passcode, 'hex')
      callback(err, filename, data)
    )

  updateEncFile: (dirpath, filename, content, passcode) ->
    content = @enc.encrypt(content, passcode)
    @fs.updateFile(path.join(dirpath, filename), content)


module.exports = EncService
