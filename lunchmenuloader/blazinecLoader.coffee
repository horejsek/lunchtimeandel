
LunchmenuLoader = require './lunchmenuLoader'


class BlazinecLoader extends LunchmenuLoader
    constructor: () ->
        @name = 'Blázinec'
        @homepage = 'http://www.blazinecandel.cz/'
        @downloadUrl = 'http://www.blazinecandel.cz/denni-menu/'
        @phoneNumber = '+420 257 316 655'
        @address =
            street: 'Nádražní 59/112'
            city: 'Praha 5'
            zip: 15000
            map:
                lat: 50.070851
                lng: 14.405109

    parse: (restaurant, $) ->
        $('.text').find('table').first().find('tr').each (i, elm) ->
            name = $(this).find('td').first().text().trim()
            price = $(this).find('td').last().text().trim()
            restaurant.addMeal name, price


module.exports =  BlazinecLoader
