
LunchmenuLoader = require './lunchmenuLoader'


class AndelkaLoader extends LunchmenuLoader
    constructor: () ->
        @name = 'Andělka'
        @homepage = 'http://www.andelka.cz'
        @downloadUrl = 'http://www.andelka.cz/denni-menu/'
        @phoneNumber = '+420 251 560 242'
        @address =
            street: 'Radlická 112/22'
            city: 'Praha 5'
            zip: 15000
            map:
                lat: 50.06867
                lng: 14.401639

    parse: (restaurant, $) ->
        $('table').first().find('tbody tr').each (i, elem) ->
            name = $(this).find('td').first().text().trim()
            price = $(this).find('td').last().text().trim()
            if name and price
                restaurant.addMeal name, price


module.exports = AndelkaLoader
