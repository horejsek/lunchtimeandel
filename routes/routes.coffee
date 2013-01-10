
module.exports = (app, models) ->
    # Non exists page redirect to homepage.
    app.use (req, res, next) ->
        res.redirect '/'

    # Redirect non-www to www.
    app.all /.*/, (req, res, next) ->
        host = req.header 'host'
        if host.match /^(www|127)\..*/i
            next()
        else
            res.redirect 301, 'http://www.' + host

    app.get '/', (req, res) ->
        models.Restaurant.find {}, (err, restaurants) ->
            res.render 'home.jade',
                title: 'LunchtimeAnděl'
                restaurants: restaurants

    # /reloaddata is working only in dev.
    app.get '/reloaddata', (req, res) ->
        host = req.header 'host'
        if host.match /^127\..*/i
            res.send 'Reloading...'
            require('../lunchmenuloader')(models)()
        else
            res.redirect '/'

    @
