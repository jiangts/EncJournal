EncService = require '../utils/encservice'

es = new EncService("#{__dirname}/../data", () ->
  console.log('enter passcode')
)

module.exports = (router) ->
  router.get '/', (req, res) ->
    testFSLayer(res)
    #res.render 'index', { title: 'testing...' }

  router.get '/:id', (req, res) ->
    es.readEncFile(".", req.params.id, (error, text) ->
      throw error if error
      res.send(text)
    )


testFSLayer = (res) ->
  
  es.createEncFile(".", 'serviceexample.txt', 'blah blah blah')
  es.listEncFiles(".", (error, files) ->
    throw error if error
    console.log files
    res.send(files)
  )
