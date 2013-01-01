
class Meal
    constructor: (name, price) ->
        @name = name
        price = parseInt(price)
        if price
            @price = price
            @printablePrice = @price + ' Kč'
        else
            @price = @printablePrice = '-'

    todb_: () ->
        name: @name
        price: @price

exports.Meal = Meal
