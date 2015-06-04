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

  fileExists: (filepath) ->
    filepath = @filepath filepath
    return fs.existsSync(filepath)

  writeFile: (filepath, content) ->
    filepath = @filepath filepath
    fs.writeFileSync(filepath, content)

  readFile: (filepath) ->
    filepath = @filepath filepath
    if @fileExists filepath
      return fs.readFileSync(filepath, 'utf8')
    else
      console.log new Error "file does not exist"

  deleteFile: (filepath) ->
    filepath = @filepath filepath
    if @fileExists filepath then fs.unlinkSync filepath

  listFiles: (filepath) ->
    filepath = @filepath filepath
    return fs.readdirSync(filepath)

module.exports = FSLayer
