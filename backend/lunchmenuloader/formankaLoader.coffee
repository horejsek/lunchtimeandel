
LunchmenuLoader = require './lunchmenuLoader'


class FormankaLoader extends LunchmenuLoader
    constructor: () ->
        @name = 'Smíchovská Formanka'
        @homepage = 'http://www.smichovskaformanka.cz/'
        @downloadUrl = 'http://www.smichovskaformanka.cz/poledni_menu.htm'
        @phoneNumber = '+420 251 560 099'
        @address =
            street: 'Ostrovského 411/24'
            city: 'Praha 5'
            zip: 15000
            map:
                lat: 50.068787
                lng: 14.400989
        @charset = 'CP1250'

    parse: (restaurant, $) ->
        $('table tr').each (i, elem) ->
            row = $(this).text().trim()
            if not row or $(this).find('td').length < 2
                return
            name = $(this).find('td').eq(0).text().trim()
            if $(this).find('td').length == 3
                name += ' ' + $(this).find('td').eq(1).text().trim()
            price = $(this).find('td').last().text().trim()
            restaurant.addMeal name, price


module.exports = FormankaLoader
