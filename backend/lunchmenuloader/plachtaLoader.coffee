
moment = require 'moment'

LunchmenuLoader = require './lunchmenuLoader'


class PlachtaLoader extends LunchmenuLoader
    constructor: () ->
        @name = 'Plachta'
        @homepage = 'http://www.plachta.cz/cs/'
        @downloadUrl = 'https://www.zomato.com/cs/widgets/daily_menu?entity_id=16506513'
        @phoneNumber = '+420 721 457 392'
        @address =
            street: 'Jindřicha Plachty 1219/27'
            city: 'Praha 5'
            zip: 15000
            map:
                lat: 50.070318
                lng: 14.405811

    parse: (restaurant, $) ->
        @lunchmenuParse_ restaurant, $


module.exports = PlachtaLoader
