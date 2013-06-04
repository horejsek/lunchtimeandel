
module.exports = (app, models) ->
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
