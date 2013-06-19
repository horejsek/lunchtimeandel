
module.exports = (models) ->
    LunchmenuLoader = require('./lunchmenuLoader')(models)

    class UKristianaLoader extends LunchmenuLoader
        constructor: () ->
            @name = 'U Kristiána'
            @homepage = 'http://www.restaurace-vinarna.cz/restaurace-ukristiana'
            @downloadUrl = 'http://www.restaurace-vinarna.cz/restaurace-ukristiana'
            @phoneNumber = '+420 603 424 700'
            @address =
                street: 'Vltavská 787/8'
                city: 'Praha 5'
                zip: 15000
                map:
                    lat: 50.070045
                    lng: 14.409481

        parse: (meals, $) ->
            $('#listek').find('table').eq(1).find('tr').each (i, elem) ->
                name = $(this).find('td').eq(1).text().trim()
                price = $(this).find('td').last().text().trim()
                if name and price
                    meals.push new models.Meal
                        name: name
                        price: price

    return UKristianaLoader
