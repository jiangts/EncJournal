FSLayer = require '../utils/fslayer'

module.exports = (router) ->
  router.get '/', (req, res, next) ->
    testFSLayer(res, next)
    #res.render 'index', { title: 'testing...' }

testFSLayer = (res, next) ->
  fsl = new FSLayer "#{__dirname}/../data"
  fsl.createFile("poop.txt", "pee")
  # fsl.updateFile("poop.txt", "")
  fsl.readFile("helloworld.txt", (error, data) ->
    if error then return next(error)
    console.log data
    #res.send(data)
  )
  
  fsl.listFiles(".", (error, files) ->
    if error then return next(error)
    res.send(files)
  )
