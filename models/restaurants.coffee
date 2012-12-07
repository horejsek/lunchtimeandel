
Meal = require('./meal').Meal
Restaurant = require('./restaurant').Restaurant

class Restaurants
    constructor: (db) ->
        @db_ = db

    get: (callback) ->
        db = @db_
        @db_.restaurants.find (err, restaurantsData) ->
            restaurants = []
            for restaurantData in restaurantsData
                restaurant = new Restaurant db, restaurantData.name, restaurantData.url, restaurantData.lastUpdate
                for meal in restaurantData.meals
                    restaurant.addMeal new Meal meal.name, meal.price
                restaurants.push restaurant
            callback err, restaurants

    clear: () ->
        @db_.restaurants.remove()

exports.Restaurants = Restaurants
