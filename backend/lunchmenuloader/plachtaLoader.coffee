
moment = require 'moment'

LunchmenuLoader = require './lunchmenuLoader'


class PlachtaLoader extends LunchmenuLoader
    constructor: () ->
        @name = 'Plachta'
        @homepage = 'http://www.plachta.cz/cs/'
        @downloadUrl = 'http://www.plachta.cz/cs/denni-menu/'
        @phoneNumber = '+420 721 457 392'
        @address =
            street: 'Jindřicha Plachty 1219/27'
            city: 'Praha 5'
            zip: 15000
            map:
                lat: 50.070318
                lng: 14.405811

    parse: (restaurant, $) ->
        today = moment().format('D. M. YYYY')
        $('#rbk h3, #rbk p').each (i, elem) ->
            if $(this).text().search(today) == -1
                return
            elm = $(this)
            while true
                elm = elm.next()
                rows = elm.text().trim().split('\r\n').filter (x) -> x if x
                break if not rows.length
                for row in rows
                    row = row.trim().split('...')
                    continue if not row[0] or not row[1]
                    restaurant.addMeal row[0], row[1].match /\d+/
            return false


module.exports = PlachtaLoader
