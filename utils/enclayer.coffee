FSLayer = require './fslayer'
crypto = require 'crypto'

class EncLayer extends FSLayer
  constructor: (@rootDir) ->
    @algorithm = 'aes-256-ctr'
    super(@rootDir)

  encrypt: (text, password) ->
    cipher = crypto.createCipher(@algorithm, password)
    crypted = cipher.update(text, 'utf8', 'binary')
    crypted += cipher.final('binary')
    return crypted
 
  decrypt: (text, password) ->
    decipher = crypto.createDecipher(@algorithm, password)
    dec = decipher.update(text, 'binary', 'utf8')
    dec += decipher.final('utf8')
    return dec
 
module.exports = EncLayer
