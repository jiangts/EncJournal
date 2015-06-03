
module.exports = (router) ->
  # GET home page.
  router.get '/', (req, res) ->
    res.render 'index', { title: 'Express' }

  router.get '/journal', (req, res) ->
    res.render 'journal'

  router.get '/example', (req, res) ->
    res.render 'example'

    # router.all(passport.protect).get('/account', account);

