
LunchmenuLoader = require './lunchmenuLoader'


class CyrilspubLoader extends LunchmenuLoader
    constructor: () ->
        @name = 'CYRIL\'s pub'
        @homepage = 'http://www.cyrilspub.cz/'
        @downloadUrl = 'http://www.cyrilspub.cz/denni-menu/'
        @phoneNumber = '+420 602 688 177'
        @address =
            street: 'Bozděchova 8'
            city: 'Praha 5'
            zip: 15000
            map:
                lat: 50.070276
                lng: 14.403237

    parse: (restaurant, $) ->
        $('table').first().find('tr').each (i, elem) ->
            name = $(this).find('td').first().text().trim()
            price = $(this).find('td').last().text().trim()
            restaurant.addMeal name, price


module.exports =  CyrilspubLoader
