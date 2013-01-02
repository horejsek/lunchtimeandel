
module.exports = (app, mongoose) ->

    Meal = mongoose.model 'Meal'
    Restaurant = mongoose.model 'Restaurant'

    lunchmenuloader = require('../utils/lunchmenuloader')(Meal, Restaurant)

    # Error 404 redirect to homepage.
    app.use (req, res, next) ->
        res.redirect '/'

    app.get '/', (req, res) ->
        Restaurant.find {}, (err, restaurants) ->
            res.render 'home.jade',
                title: 'LunchtimeAnděl'
                restaurants: restaurants

    app.get '/reloaddata', (req, res) ->
        lunchmenuloader()
        res.send 'Reloading...'

    @
