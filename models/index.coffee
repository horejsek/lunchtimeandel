
moment = require 'moment'

module.exports = (mongoose) ->
    Schema = mongoose.Schema

    Meal = new Schema
        name: String
        price: Number
    Meal.path('price').set (v) ->
        return parseInt v
    Meal.methods.getPrintablePrice = () ->
        if @price then @price + ' Kč' else '-'

    Restaurant = new Schema
        name: String
        url: String
        lastUpdate: Date
        meals: [Meal]
    Restaurant.methods.getPrintalbeLastUpdate = () ->
        moment(@lastUpdate).format 'D. MMMM v H:mm'

    Meal: mongoose.model 'Meal', Meal
    Restaurant: mongoose.model 'Restaurant', Restaurant
