
moment = require 'moment'

LunchmenuLoader = require './lunchmenuLoader'


class ZtracenkaLoader extends LunchmenuLoader
    constructor: () ->
        @name = 'Ztracenka'
        @homepage = 'http://www.naztracene.cz'
        @downloadUrl = 'http://www.naztracene.cz/denni/jidelni-listek_soubory/sheet001.htm'
        @phoneNumber = '+420 251 560 088'
        @address =
            street: 'Zoubkova 4'
            city: 'Praha 5'
            zip: 15000
            map:
                lat: 50.0671918
                lng: 14.3981533
        @charset = 'CP1250'

    parse: (restaurant, $) ->
        $('table tr').each (i, elem) ->
            amount = $(this).find('td').eq(0).text().trim()
            name = $(this).find('td').eq(1).text().trim()
            price = $(this).find('td').eq(2).text().trim().match /\d+/
            if name and price
                restaurant.addMeal amount + ' ' + name, price[0]


module.exports = ZtracenkaLoader
