
moment = require 'moment'

LunchmenuLoader = require './lunchmenuLoader'


class ProstorLoader extends LunchmenuLoader
    constructor: () ->
        @name = 'Prostor'
        @homepage = 'http://www.prostor.je'
        @downloadUrl = 'http://www.prostor.je'
        @phoneNumber = '+420 257 219 938'
        @address =
            street: 'Lidická 25'
            city: 'Praha 5'
            zip: 15000
            map:
                lat: 50.072048
                lng: 14.406664

    parse: (restaurant, $) ->
        $('#daily-menu li').each (i, elem) ->
            row = $(this).text().trim().match /^(.+?)(\d+)/
            if row and row.length == 3
                restaurant.addMeal row[1], row[2]


module.exports = ProstorLoader
