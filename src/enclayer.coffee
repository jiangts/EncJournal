crypto = require 'crypto'

class EncLayer
  constructor: (@rootDir, @algorithm = 'aes-256-ctr', @confirmDecrypt = true) ->

  encrypt: (text, passcode, enctype = 'binary') ->
    if @confirmDecrypt then text = passcode + text
    cipher = crypto.createCipher(@algorithm, passcode)
    crypted = cipher.update(text, 'utf8', enctype)
    crypted += cipher.final(enctype)
    return crypted
 
  decrypt: (text, passcode, enctype = 'binary') ->
    decipher = crypto.createDecipher(@algorithm, passcode)
    dec = decipher.update(text, enctype, 'utf8')
    dec += decipher.final('utf8')
    if @confirmDecrypt
      return dec.substr(passcode.length) if dec.indexOf(passcode) is 0
      return null
    return dec
 
module.exports = EncLayer
