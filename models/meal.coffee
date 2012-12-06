
class Meal
    constructor: (name, price) ->
        @name = name
        @price = price

    todb_: () ->
        name: @name
        price: @price

exports.Meal = Meal
