
LunchmenuLoader = require './lunchmenuLoader'


class SantoskaLoader extends LunchmenuLoader
    constructor: () ->
        @name = 'Santoška'
        @homepage = 'http://www.klubsantoska.cz/'
        @downloadUrl = 'http://www.klubsantoska.cz/denni%20menu.html'
        @phoneNumber = '+420 251 560 045'
        @address =
            street: 'U Nikolajky 18'
            city: 'Praha 5'
            zip: 15000
            map:
                lat: 50.067052
                lng: 14.397708
        @charset = 'CP1252'

    parse: (restaurant, $) ->
        $('table.TableGrid tr').each (i, elem) ->
            name = $(this).find('td').eq(1).text().trim()
            price = $(this).find('td').last().text().trim()
            restaurant.addMeal name, price


module.exports = SantoskaLoader
