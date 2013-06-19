
module.exports = (Schema) ->
    Meal = new Schema
        name: String
        price: Number

    Meal.path('name').set (v) ->
        return v.replace('&nbsp;', ' ')

    Meal.path('price').set (v) ->
        return parseInt v

    Meal.methods.getPrintablePrice = () ->
        if @price then @price + ' Kč' else '-'

    return Meal
