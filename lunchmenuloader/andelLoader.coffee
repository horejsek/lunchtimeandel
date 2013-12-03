
LunchmenuLoader = require './lunchmenuLoader'


class AndelLoader extends LunchmenuLoader
    constructor: () ->
        @name = 'Anděl'
        @homepage = 'http://www.restauraceandel.cz'
        @downloadUrl = 'http://www.restauraceandel.cz/cz/jidelni-listek/dnesni-nabidka/'
        @phoneNumber = '+420 257 323 234'
        @address =
            street: 'Nádražní 114'
            city: 'Praha 5'
            zip: 15000
            map:
                lat: 50.070985
                lng: 14.404854

    parse: (restaurant, $) ->
        $('table.Foodmenu').first().find('tr').each (i, elem) ->
            name = $(this).find('.cAmount').text().trim() + ' ' + $(this).find('.cFood').text().trim()
            price = $(this).find('.cPrice').text().trim()
            if name and price
                restaurant.addMeal name, price


module.exports = AndelLoader
