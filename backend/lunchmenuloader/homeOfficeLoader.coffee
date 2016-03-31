
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
        days = ['Pondělí', 'Úterý', 'Středa', 'Čtvrtek', 'Pátek', 'Sobota', 'Neděle']
        date = new Date()
        day_string = days[(date.getDay() - 1)] + ' ' + date.getDate() + '/' + (date.getMonth() + 1)
        location = 'Smíchov'
        location_after = 'Karlín'
        current_day = false
        location_found = false
        $('table tr').each (i, elem) ->
            name = $(this).find('td').text().trim()

            if name is day_string
               current_day = true

            if name is location && current_day == true
                location_found = true

            if name is location_after
                current_day = false
                location_found = false

            if current_day == true && location_found == true && name != location
      	        restaurant.addMeal name, '-'


module.exports = HomeOfficeLoader
