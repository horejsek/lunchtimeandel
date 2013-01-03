
module.exports = (app, models) ->
    # Non exists page redirect to homepage.
    app.use (req, res, next) ->
        res.redirect '/'

    app.get '/', (req, res) ->
        models.Restaurant.find {}, (err, restaurants) ->
            res.render 'home.jade',
                title: 'LunchtimeAnděl'
                restaurants: restaurants

    @
