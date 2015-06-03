FSLayer = require '../utils/fslayer'

module.exports = (router) ->
  router.get '/', (req, res) ->
    testFSLayer(res)
    #res.render 'index', { title: 'testing...' }

testFSLayer = (res) ->
  fsl = new FSLayer "#{__dirname}/../data"
  fsl.createFile("helloworld.txt", "hello 2")
  fsl.updateFile("helloworld.txt", "three!!!")
  fsl.readFile("helloworld.txt", (error, data) ->
    throw error if error
    console.log data
    res.send(data)
  )
  
