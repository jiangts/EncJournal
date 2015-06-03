EncLayer = require '../utils/enclayer'

module.exports = (router) ->
  router.get '/', (req, res) ->
    testEncLayer(res)

testEncLayer = (res) ->
  enc = new EncLayer "#{__dirname}/../data"
  crypted = enc.encrypt('hello', 'testuser')
  console.log crypted
  uncrypted = enc.decrypt(crypted, 'testuser')
  console.log uncrypted
  res.json crypted: crypted, uncrypted: uncrypted
