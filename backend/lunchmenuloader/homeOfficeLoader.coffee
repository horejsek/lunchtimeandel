
moment = require 'moment'

LunchmenuLoader = require './lunchmenuLoader'


class HomeOfficeLoader extends LunchmenuLoader
    constructor: () ->
        @name = 'Home Office'
        @homepage = 'http://homeofficebistro.cz/'
        @downloadUrl = 'http://homeofficebistro.cz/tydenni-menu/'
        @phoneNumber = '+420 778 767 768'
        @address =
            street: 'Radlická 3185/1C'
            city: 'Praha 5'
            zip: 15000
            map:
                lat: 50.0716481
                lng: 14.4011792

    parse: (restaurant, $) ->
        today = moment().format('dddd D/M')
        location = 'Radlická'
        locationAfter = ''
        dayFound = false
        locationFound = false
        $('table tr').each (i, elem) ->
            name = $(this).find('td').text().trim()

            if name.toLowerCase() is today
               dayFound = true

            if name is location && dayFound == true
                locationFound = true

            if name is locationAfter
                dayFound = false
                locationFound = false

            if dayFound == true && locationFound == true && name != location
                restaurant.addMeal name, '-'


module.exports = HomeOfficeLoader
