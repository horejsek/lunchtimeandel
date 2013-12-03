
LunchmenuLoader = require './lunchmenuLoader'


class LaCambusaLoader extends LunchmenuLoader
    constructor: () ->
        @name = 'La Cambusa'
        @homepage = 'http://www.lacambusa.cz'
        @downloadUrl = 'http://www.lacambusa.cz/jidelni-listek'
        @phoneNumber = '+420 240 200 218'
        @address =
            street: 'Stroupežnického 9'
            city: 'Praha 5'
            zip: 15000
            map:
                lat: 50.06976
                lng: 14.402803

    parse: (restaurant, $) ->
        n = (new Date()).getDay()
        $('.roktabs-tab' + n + ' p').each (i, elem) ->
            row = $(this).text().trim()
            if not row
                return
            row = row.split /\ (?=[0-9 ]+,-)/
            restaurant.addMeal row[0], row[1]


module.exports = LaCambusaLoader
