fs = require 'fs'
path = require 'path'

path.isAbsolute = (filename)->
  if filename[0] is '/' then return true else return false

###
Quick "documentation"
- Only list and read need callbacks.
- Create and update need contents
- Error throwing is janky rn
###

class FSLayer
  constructor: (@rootDir) ->
    @rootDir = path.normalize @rootDir

  filepath: (filename) ->
    return if path.isAbsolute filename then filename else path.join(@rootDir, filename)

  getFileInfo: (filepath, callback) ->
    filepath = @filepath filepath
    fs.exists(filepath, (exists) ->
      if exists
        fs.statSync(filepath, (err, stats) ->
          throw err if err
          callback(stats)
        )
      else callback(false)
    )

  createFile: (filepath, content) ->
    filepath = @filepath filepath
    @getFileInfo(filepath, (stats) ->
      # file exists
      if stats
        # throw new Error("file already exists")
        console.log 'file already exists'
      # doesn't exist
      else
        fs.writeFileSync(filepath, content, (err) ->
          throw err if err
        )
    )

  readFile: (filepath, callback) ->
    filepath = @filepath filepath
    @getFileInfo(filepath, (stats) ->
      # file exists
      if stats
        # for some reason binary is utf8??
        fs.readFileSync(filepath, 'utf8', (err, data) ->
          callback(err, data)
        )
      # doesn't exist
      else
        callback(new Error("file does not exist"), null)
    )

  updateFile: (filepath, content) ->
    filepath = @filepath filepath
    @getFileInfo(filepath, (stats) ->
      # file exists
      if stats
        fs.writeFileSync(filepath, content, (err) ->
          throw err if err
        )
      # doesn't exist
      else
        console.log 'file does not exist'
    )

  # deleteFile: () ->

  listFiles: (filepath, callback) ->
    filepath = @filepath filepath
    fs.readdirSync(filepath, (err, files) ->
      callback(err, files)
    )

module.exports = FSLayer

