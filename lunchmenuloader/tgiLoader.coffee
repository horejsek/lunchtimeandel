
LunchmenuLoader = require './lunchmenuLoader'


class TGILoader extends LunchmenuLoader
    constructor: () ->
        @name = 'T.G.I. Friday\'s'
        @homepage = 'http://www.tgifridays.cz/cs/na-andelu/'
        @downloadUrl = 'http://www.tgifridays.cz/cs/na-andelu/obedove-menu-andel/'
        @phoneNumber = '+420 257 286 261'
        @address =
            street: 'Nádražní 110'
            city: 'Praha 5'
            zip: 15000
            map:
                lat: 50.070572
                lng: 14.405136

    parse: (restaurant, $) ->
        $('#articles table tr').each (i, elem) ->
            name = $(this).find('td').first().text().trim()
            price = $(this).find('td').last().text().trim()
            restaurant.addMeal name, price


module.exports = TGILoader
