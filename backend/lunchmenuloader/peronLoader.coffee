
moment = require 'moment'

LunchmenuLoader = require './lunchmenuLoader'


class PeronLoader extends LunchmenuLoader
    constructor: () ->
        @name = 'U perónu'
        @homepage = 'http://www.uperonu.cz/'
        @downloadUrl = 'http://www.uperonu.cz/jidelni-listek/tydenni-menu-1100-1500.html'
        @phoneNumber = '+420 721 441 440'
        @address =
            street: 'Nádražní 40'
            city: 'Praha 5'
            zip: 15000
            map:
                lat: 50.069773
                lng: 14.405764

    parse: (restaurant, $) ->
        today = moment().format('DD.MM. YYYY')
        $('.teaserarticles .item').each (i, elem) ->
            if $(this).text().search(today) == -1
                return
            $(this).find('table tr').each (i, elem) ->
                name = $(this).find('td').first().text().trim()
                price = $(this).find('td').last().text().trim()
                if name != price and price
                    restaurant.addMeal name, price


module.exports = PeronLoader
