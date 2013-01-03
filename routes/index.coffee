
cronJob = require('cron').CronJob

module.exports = (app, mongoose) ->

    Meal = mongoose.model 'Meal'
    Restaurant = mongoose.model 'Restaurant'

    lunchmenuloader = require('../utils/lunchmenuloader')(Meal, Restaurant)

    # Non exists page redirect to homepage.
    app.use (req, res, next) ->
        res.redirect '/'

    app.get '/', (req, res) ->
        Restaurant.find {}, (err, restaurants) ->
            res.render 'home.jade',
                title: 'LunchtimeAnděl'
                restaurants: restaurants

    job = new cronJob '0 0 8-12 * * *', lunchmenuloader, null, true, 'Europe/Prague'

    @
