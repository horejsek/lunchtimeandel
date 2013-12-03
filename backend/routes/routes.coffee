
models = require '../models'


module.exports = (app) ->
    # Non exists page redirect to homepage.
    app.use (req, res, next) ->
        res.redirect '/'

    app.get '/', (req, res) ->
        models.Restaurant.find {}, (err, restaurants) ->
            res.render 'home.jade',
                title: __('LunchtimeAndel')
                restaurants: restaurants

    # /reloaddata is working only in dev.
    app.get '/reloaddata', (req, res) ->
        host = req.header 'host'
        if host.match /^127\..*/i
            res.send 'Reloading...'
            require('../lunchmenuloader')()
        else
            res.redirect '/'

    @
