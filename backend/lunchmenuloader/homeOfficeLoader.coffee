
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
        days = ['Ponděl�', 'Úterý', 'Středa', 'Čtvrtek', 'Pátek', 'Sobota', 'Neděle']
        d = new Date()
        n = days[(d.getDay() - 1)] + ' ' + d.getDate() + '/' + (d.getMonth() + 1)
        l = 'Smíchov'
        l_end = 'Karlín'
        current = false
        location = false
        $('div.wpb_text_column.wpb_content_element div table tr').each (i, elem) ->
            name = $(this).find('td').text().trim()

            if name is n
               current = true

            if name is l && current == true 
                location = true

            if name is l_end
                current = false
                location = false

            if current == true && location == true && name != l
      	        restaurant.addMeal name, '-'


module.exports = HomeOfficeLoader
