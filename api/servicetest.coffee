EncService = require '../utils/encservice'

es = new EncService("#{__dirname}/../data", () ->
  # TODO make user give passcode
  console.log('enter passcode')
)

module.exports = (router) ->
  router.get '/', (req, res, next) ->
    es.createEncFile(".", 'serviceexample.txt', 'blah blah blah')
    es.listEncFiles(".", (error, files) ->
      if error then return next error
      console.log files
      res.send(files)
    )

  router.get '/create/:id', (req, res) ->
    es.createEncFile(".", req.params.id, "the filename is #{req.params.id}")
    res.json success: true

  router.get '/:id', (req, res, next) ->
    es.readEncFile(".", req.params.id, (error, title, text) ->
      if error then return next(error)
      else res.json(title: title, content: text)
    )

