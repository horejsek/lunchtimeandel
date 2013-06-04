
i18n = require 'i18n'
moment = require 'moment'

module.exports = (mongoose) ->
    Schema = mongoose.Schema

    Meal = new Schema
        name: String
        price: Number
    Meal.path('name').set (v) ->
        return v.replace('&nbsp;', ' ')
    Meal.path('price').set (v) ->
        return parseInt v
    Meal.methods.getPrintablePrice = () ->
        if @price then @price + ' Kč' else '-'

    Restaurant = new Schema
        name: String
        url: String
        lunchmenuUrl: String
        lastUpdate: Date
        meals: [Meal]
        map:
            lat: Number
            lon: Number
    Restaurant.methods.getPrintalbeLastUpdate = () ->
        moment.lang i18n.getLocale()
        moment(@lastUpdate).format __ 'MMMM D, H:mm A'
    Restaurant.methods.getRandomMeal = () ->
        meals = []
        for meal in @meals
            meals.push meal if meal.price > 50

        rand = Math.floor(Math.random() * meals.length)
        meals[rand]
    Restaurant.pre 'save', (next) ->
        mealNames = []
        meals = []
        for meal in @meals
            if meal.name not in mealNames
                meals.push meal
            mealNames.push meal.name
        @meals = meals
        next()
    Restaurant.statics.random = (callback) ->
        that = @
        @count (err, count) ->
            if err
                return callback err
            rand = Math.floor(Math.random() * count)
            that.findOne().skip(rand).exec callback

    Meal: mongoose.model 'Meal', Meal
    Restaurant: mongoose.model 'Restaurant', Restaurant
