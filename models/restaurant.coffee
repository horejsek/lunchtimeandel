
i18n = require 'i18n'
moment = require 'moment'
mongoose = require 'mongoose'
slug = require 'slug'

Meal = require './meal'


Restaurant = new mongoose.Schema
    id: String
    name: String
    urls:
        homepage: String
        lunchmenu: String
    lastUpdate: Date
    meals: [Meal]
    phoneNumber: String
    address:
        street: String
        city: String
        zip: Number
        map:
            lat: Number
            lng: Number

Restaurant.methods.getPrintalbeLastUpdate = () ->
    moment.lang i18n.getLocale()
    moment(@lastUpdate).format __ 'MMMM D, H:mm A'

Restaurant.methods.getRandomMeal = () ->
    meals = []
    for meal in @meals
        meals.push meal if meal.price > 50

    rand = Math.floor(Math.random() * meals.length)
    meals[rand]

Restaurant.methods.addMeal = (name, price) ->
    models = require './'
    @meals.push new models.Meal
        name: name
        price: price

Restaurant.pre 'save', (next) ->
    mealNames = []
    meals = []
    for meal in @meals
        if meal.name not in mealNames
            meals.push meal
        mealNames.push meal.name
    @meals = meals
    @id = slug(@name).toLowerCase()
    next()

Restaurant.statics.random = (callback) ->
    @find {meals: {$not: {$size: 0}}, 'meals.price': {$gt: 50}}, (err, restaurants) ->
        if err
            return callback err
        rand = Math.floor(Math.random() * restaurants.length)
        callback err, restaurants[rand]


module.exports = Restaurant
