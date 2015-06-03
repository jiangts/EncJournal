fs = require 'fs'
path = require 'path'

###
Quick "documentation"
- Only list and read need callbacks.
- Create and update need contents
- Error throwing is janky rn
###

class FSLayer
  constructor: (@rootDir) ->
    @rootDir = path.normalize @rootDir
    console.log @rootDir

  filepath: (filename) ->
    return if path.isAbsolute filename then filename else path.join(@rootDir, filename)

  getFileInfo: (filepath, callback) ->
    filepath = @filepath filepath
    fs.exists(filepath, (exists) ->
      if exists
        fs.stat(filepath, (error, stats) ->
          throw error if error
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
        fs.writeFile(filepath, content, (error) ->
          throw error if error
        )
    )

  readFile: (filepath, callback) ->
    filepath = @filepath filepath
    @getFileInfo(filepath, (stats) ->
      # file exists
      if stats
        fs.readFile(filepath, 'binary', (error, data) ->
          throw error if error
          # stats.data = data
          callback(null, data)
        )
      # doesn't exist
      else
        callback(new Error("file does not exist"), null)
    )

  updateFile: (filepath, contents) ->
    filepath = @filepath filepath
    @getFileInfo(filepath, (stats) ->
      # file exists
      if stats
        fs.writeFile(filepath, contents, (error) ->
          throw error if error
        )
      # doesn't exist
      else
        console.log 'file does not exist'
    )

  deleteFile: () ->

  listFiles: (filepath, callback) ->
    filepath = @filepath filepath
    fs.readdir(filepath, (error, files) ->
      callback(error, files)
    )

module.exports = FSLayer

