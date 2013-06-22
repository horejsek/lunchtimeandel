
module.exports = (app, models) ->
    app.get '/api', (req, res) ->
        res.render 'api.jade',
            title: __('LunchtimeAndel') + ' API'
            apis: [
                {
                    url: '/api/listall'
                    description: __('Load all restaurants with their meals.')
                }
                {
                    url: '/api/meal/random'
                    description: __('Get random meal with information about restaurant.')
                }
            ]

    app.get '/api/listall', (req, res) ->
        models.Restaurant.find {}, (err, restaurants) ->
            result = []
            for restaurant in restaurants
                meals = []
                for meal in restaurant.meals
                    meals.push getMealAttributes meal
                restaurant = getRestaurantAttributes restaurant
                restaurant.meals = meals
                result.push restaurant
            res.json result

    app.get '/api/meal/random', (req, res) ->
        models.Restaurant.random (err, restaurant) ->
            meal = restaurant.getRandomMeal()
            res.json
                restaurant: getRestaurantAttributes restaurant
                meal: getMealAttributes meal

    getRestaurantAttributes = (restaurant) ->
        id: restaurant.id
        name: restaurant.name
        urls: restaurant.urls
        lastUpdate: restaurant.lastUpdate
        lastUpdateStr: restaurant.getPrintalbeLastUpdate()
        phoneNumber: restaurant.phoneNumber
        address: restaurant.address

    getMealAttributes = (meal) ->
        name: meal.name
        price: meal.price
        priceStr: meal.getPrintablePrice()

    @
