
module.exports = (router) ->
  # GET home page.
  router.get '/', (req, res) ->
    res.render 'index', { title: 'Express' }

    # router.all(passport.protect).get('/account', account);

