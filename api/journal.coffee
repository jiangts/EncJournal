
module.exports = (router) ->
  # GET home page.
  router.get '/', (req, res) ->
    res.render 'journal'

