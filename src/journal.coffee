EncService = require './encservice'
async = require 'async'
prompt = require 'prompt'

# TODO eventually have a config file

module.exports = ->
  es = new EncService "#{__dirname}/../data", "unsafe"

  prompt.start()
  passcodeSchema =
    properties:
      passcode:
        hidden: true

  arg = process.argv[2]
  if arg is 'encrypt'
    prompt.get(passcodeSchema, (err, result) ->
      es.encryptDir('unsafe', result.passcode)
    )
  if arg is 'decrypt'
    prompt.get(passcodeSchema, (err, result) ->
      es.decryptDir('.', result.passcode)
    )

