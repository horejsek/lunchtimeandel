
moment = require 'moment'

LunchmenuLoader = require './lunchmenuLoader'


class PeronLoader extends LunchmenuLoader
    constructor: () ->
        @name = 'Perón'
        @homepage = 'http://www.peronsmichov.cz/'
        @downloadUrl = 'http://www.lunchtime.cz/radegastovna-peron/pw/denni-menu/'
        @phoneNumber = '+420 602 741 401'
        @address =
            street: 'Stroupežnického 20'
            city: 'Praha 5'
            zip: 15000
            map:
                lat: 50.07072
                lng: 14.404782

    parse: (restaurant, $) ->
        today = moment().format('YYYY-MM-DD')
        $('#restDailyMenu'+today+'Ajax tr').each (i, elem) ->
            name = $(this).find('td').first().text().trim()
            price = $(this).find('td').last().text().trim()
            restaurant.addMeal name, price


module.exports = PeronLoader
