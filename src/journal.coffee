EncService = require './encservice'
async = require 'async'
prompt = require 'prompt'

# TODO eventually have a config file

module.exports = ->
  es = new EncService "#{__dirname}/../data"

  es.createEncFile('.', 'pee.txt', 'testing this', 'testsecret')
  es.readEncFile('.', 'ed5ffd26a1175f1f3ffe450cbe6afff8c16e.enc', (err, filename, data) ->
    console.log err if err
    console.log filename
    console.log data
  , 'testsecret')
  es.listEncFiles('.', (err, data) ->
    console.log data
  , 'testsecret')

