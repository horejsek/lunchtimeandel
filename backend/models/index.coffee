
mongoose = require 'mongoose'

# I don't want to have some global object with models. So this is little hack.
# So I can now inmport this module more times without error.
try
    Meal = mongoose.model 'Meal'
    Restaurant = mongoose.model 'Restaurant'
catch e
    if e.name is 'MissingSchemaError'
        Meal = mongoose.model 'Meal', require './meal'
        Restaurant = mongoose.model 'Restaurant', require './restaurant'

module.exports =
    Meal: Meal
    Restaurant: Restaurant
