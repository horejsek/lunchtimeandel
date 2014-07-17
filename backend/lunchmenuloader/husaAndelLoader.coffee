
moment = require 'moment'

LunchmenuLoader = require './lunchmenuLoader'


class HusaLoader extends LunchmenuLoader
    constructor: () ->
        @name = 'Potrefená Husa (Anděl)'
        @homepage = 'http://www.staropramen.cz/husa/restaurace-praha-andel'
        @downloadUrl = 'http://www.staropramen.cz/husa/restaurace-praha-andel/denni-menu'
        @phoneNumber = '+420 257 941 669'
        @address =
            street: 'Nádražní 222/23'
            city: 'Praha 5'
            zip: 15000
            map:
                lat: 50.070479
                lng: 14.404525

    parse: (restaurant, $) ->
        today = moment().format('DD. MM. YYYY')
        $('menu den[datum="'+today+'"] jidlo').each (i, elem) ->
            name = $(this).text().trim()
            price = $(this).attr('cena')
            restaurant.addMeal name, price


module.exports = HusaLoader
