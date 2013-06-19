
module.exports = (mongoose) ->
    Schema = mongoose.Schema

    Meal = require('./meal')(Schema)
    Restaurant = require('./restaurant')(Schema)

    Meal: mongoose.model 'Meal', Meal
    Restaurant: mongoose.model 'Restaurant', Restaurant
