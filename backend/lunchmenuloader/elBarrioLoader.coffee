
LunchmenuLoader = require './lunchmenuLoader'


class ElBarrioLoader extends LunchmenuLoader
    constructor: () ->
        @name = 'El Barrio de Ángel'
        @homepage = 'http://www.elbarrio.cz/'
        @downloadUrl = 'http://www.elbarrio.cz/cs/restaurant/menu/poledni-menu'
        @phoneNumber = '+420 725 535 555'
        @address =
            street: 'Lidická 284/42'
            city: 'Praha 5'
            zip: 15000
            map:
                lat: 50.072173
                lng: 14.404519

    parse: (restaurant, $) ->
        $('.menu-kategorie tr').each (i, elem) ->
            row = $(this).text().trim()
            if not row
                return
            name = $(this).find('td').eq(1).text().trim()
            price = $(this).find('td').eq(3).text().trim()
            restaurant.addMeal name, price


module.exports = ElBarrioLoader
