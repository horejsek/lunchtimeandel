
LunchmenuLoader = require './lunchmenuLoader'


class HusaLoader extends LunchmenuLoader
    constructor: () ->
        @name = 'Potrefená Husa (Anděl)'
        @homepage = 'http://www.staropramen.cz/husa/restaurace-praha-andel/denni-menu'
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
        $('#denniMenuCarousel li').first().find('li').each (i, elem) ->
            name = $(this).find('.name').text().trim()
            price = $(this).find('.price').text().trim()
            restaurant.addMeal name, price


module.exports = HusaLoader
