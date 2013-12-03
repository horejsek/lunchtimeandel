
LunchmenuLoader = require './lunchmenuLoader'


class IlNostroLoader extends LunchmenuLoader
    constructor: () ->
        @name = 'Il Nostro'
        @homepage = 'http://www.ilnostro.cz'
        @downloadUrl = 'http://www.ilnostro.cz/cz/tydenni-menu'
        @phoneNumber = '+420 251 553 898'
        @address =
            street: 'Plzeňská 608/7'
            city: 'Praha 5'
            zip: 15000
            map:
                lat: 50.071509
                lng: 14.400603

    parse: (restaurant, $) ->
        n = (new Date()).getDay()
        $('.obsah table').each (i, elem) ->
            if i+1 is n
                $(this).find('tr').each (i, elem) ->
                    name = $(this).find('td').eq(1).text().trim()
                    price = $(this).find('td').last().text().trim()
                    restaurant.addMeal name, price


module.exports = IlNostroLoader
