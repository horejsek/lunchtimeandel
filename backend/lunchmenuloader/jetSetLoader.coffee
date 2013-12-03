
LunchmenuLoader = require './lunchmenuLoader'


class JetSetLoader extends LunchmenuLoader
    constructor: () ->
        @name = 'Jet Set'
        @homepage = 'http://www.jetset.cz/'
        @downloadUrl = 'http://www.docservis.cz/jetset/www/cs/home/daily-menu'
        @phoneNumber = '+420 257 327 251'
        @address =
            street: 'Radlická 3185/1C'
            city: 'Praha 5'
            zip: 15000
            map:
                lat: 50.071646
                lng: 14.401585

    parse: (restaurant, $) ->
        $('tbody tr').each (i, elem) ->
            row = $(this).text().trim().split /\ (?=[0-9 ]+,-)/
            restaurant.addMeal row[0], row[1]


module.exports = JetSetLoader
