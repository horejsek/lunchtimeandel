
module.exports = (app, models) ->
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
            require('../lunchmenuloader')(models)()
        else
            res.redirect '/'

    app.get '/api/listall', (req, res) ->
        models.Restaurant.find {}, (err, restaurants) ->
            result = []
            for restaurant in restaurants
                meals = []
                for meal in restaurant.meals
                    meals.push
                        name: meal.name
                        price: meal.price
                result.push
                    name: restaurant.name
                    url: restaurant.url
                    lunchmenuUrl: restaurant.lunchmenuUrl
                    lastUpdate: restaurant.lastUpdate
                    map: restaurant.map
                    meals: meals
            res.json result

    app.get '/api/meal/random', (req, res) ->
        models.Restaurant.random (err, restaurant) ->
            meals = []
            for meal in restaurant.meals
                meals.push meal if meal.price > 50

            rand = Math.floor(Math.random() * meals.length)
            meal = meals[rand]
            res.json
                restaurantName: restaurant.name
                mealName: meal.name
                mealPrice: meal.getPrintablePrice()

    @
