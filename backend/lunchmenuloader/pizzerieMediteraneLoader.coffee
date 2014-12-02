
LunchmenuLoader = require './lunchmenuLoader'


class PizzerieMediteraneLoader extends LunchmenuLoader
    constructor: () ->
        @name = 'Pizzerie Mediterane'
        @homepage = 'http://www.pizzeriemediterane.cz'
        @downloadUrl = 'https://www.zomato.com/widgets/daily_menu?entity_id=16506335'
        @phoneNumber = '+420 257 320 579'
        @address =
            street: 'Radlická 3179/1e'
            city: 'Praha 5'
            zip: 15000
            map:
                lat: 50.071295
                lng: 14.40159

    parse: (restaurant, $) ->
        @lunchmenuParse_ restaurant, $


module.exports = PizzerieMediteraneLoader
