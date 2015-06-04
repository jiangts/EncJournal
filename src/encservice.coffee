EncLayer = require './enclayer'
FSLayer = require './fslayer'
path = require 'path'

# TODO this dirpath crap is super disgusting
## TODO can make hex to base32 converter.
## do so by iterating over 2 chars at a time and mapping them to a base32 char
# TODO splinter files by directory

# High level APIs to be called by enc-cli and the web app
class EncService
  constructor: (@rootDir, @workingDir) ->
    @fs = new FSLayer(@rootDir)
    @enc = new EncLayer(@rootDir)

  encryptDir: (dirpath, passcode) ->
    files = @fs.listFiles(dirpath)
    for file in files
      @encryptFile(dirpath, file, passcode)
      @fs.deleteFile(path.join(dirpath, file))

  encryptFile: (dirpath, title, passcode) ->
    content = @fs.readFile(path.join(dirpath, title))
    @writeEncryptedFile(".", title, content, passcode)

  writeEncryptedFile: (dirpath, title, content, passcode) ->
    filename = @enc.encrypt(title, passcode, 'hex') + '.enc'
    content = @enc.encrypt(content, passcode)
    @fs.writeFile(path.join(dirpath, filename), content)


  decryptDir: (dirpath, passcode) ->
    files = @fs.listFiles(dirpath)
    for file in files
      console.log path.extname(file)
      if path.extname(file) is '.enc'
        @decryptFile(dirpath, file, passcode)

  decryptFile: (dirpath, filename, passcode) ->
    data = @fs.readFile(path.join(dirpath, filename))
    # return @deserializeFile @enc.decrypt(data, passcode)
    title = @enc.decrypt(filename, passcode, 'hex')
    content = @enc.decrypt(data, passcode)
    @fs.writeFile(path.join(@workingDir, title), content)
  

module.exports = EncService
