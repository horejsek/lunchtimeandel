
moment = require 'moment'

module.exports = (models) ->
    LunchmenuLoader = require('./lunchmenuLoader')(models)

    class PizzerieMediteraneLoader extends LunchmenuLoader
        constructor: () ->
            @name = 'Pizzerie Mediterane‎'
            @homepage = 'http://www.pizzeriemediterane.cz'
            @downloadUrl = 'http://www.pizzeriemediterane.cz/denni_menu.php'
            @phoneNumber = '+420 257 320 579'
            @address =
                street: 'Radlická 3179/1e'
                city: 'Praha 5'
                zip: 15000
                map:
                    lat: 50.071295
                    lng: 14.40159

        parse: (meals, $) ->
            today = moment().format('D.M.YYYY')
            if $('#container').text().search(today) == -1
                return
            $('table').find('tr').each (i, elem) ->
                name = $(this).find('td').first().text().trim()
                price = $(this).find('td').last().text().trim()
                meals.push new models.Meal
                    name: name
                    price: price

    return PizzerieMediteraneLoader
