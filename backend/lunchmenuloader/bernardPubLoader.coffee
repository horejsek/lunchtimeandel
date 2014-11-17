
LunchmenuLoader = require './lunchmenuLoader'


class BernardPubLoader extends LunchmenuLoader
    constructor: () ->
        @name = 'Bernard Pub'
        @homepage = 'http://bernardpub.cz/andel/'
        @downloadUrl = 'http://bernardpub.cz/andel/'
        @phoneNumber = '+420 251 560 242'
        @address =
            street: 'Radlická 112/22'
            city: 'Praha 5'
            zip: 15000
            map:
                lat: 50.06867
                lng: 14.401639

    parse: (restaurant, $) ->
        $('#jidelnilistek').first().find('.polozka').each (i, elem) ->
            name = $(this).find('strong').first().text().trim()
            price = $(this).find('em').first().text().trim()
            if name and price
                restaurant.addMeal name, price


module.exports = BernardPubLoader
