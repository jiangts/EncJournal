FSLayer = require '../utils/fslayer'

module.exports = (router) ->
  router.get '/', (req, res) ->
    testFSLayer(res)
    #res.render 'index', { title: 'testing...' }

testFSLayer = (res) ->
  fsl = new FSLayer "#{__dirname}/../data"
  fsl.createFile("poop.txt", "pee")
  # fsl.updateFile("poop.txt", "")
  fsl.readFile("helloworld.txt", (error, data) ->
    throw error if error
    console.log data
    #res.send(data)
  )
  
  fsl.listFiles(".", (error, files) ->
    throw error if error
    res.send(files)
  )
