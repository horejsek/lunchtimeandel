
LunchmenuLoader = require './lunchmenuLoader'


class LokalblokLoader extends LunchmenuLoader
    constructor: () ->
        @name = 'Lokal blok'
        @homepage = 'http://lokalblok.cz/restaurace/'
        @downloadUrl = 'https://www.zomato.com/widgets/daily_menu?entity_id=16507018'
        @phoneNumber = '+420 251 511 490'
        @address =
            street: 'Nám. 14. října 10'
            city: 'Praha 5'
            zip: 15000
            map:
                lat: 50.073004
                lng: 14.405016

    parse: (restaurant, $) ->
        @lunchmenuParse_ restaurant, $


module.exports = LokalblokLoader
