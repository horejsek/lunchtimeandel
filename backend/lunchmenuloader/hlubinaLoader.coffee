
moment = require 'moment'

LunchmenuLoader = require './lunchmenuLoader'


class HlubinaLoader extends LunchmenuLoader
    constructor: () ->
        @name = 'Hlubina'
        @homepage = 'http://www.restaurace-hlubina.cz/'
        @downloadUrl = 'http://www.lunchtime.cz/hlubina/pw/denni-menu/'
        @phoneNumber = '+420 257 328 184'
        @address =
            street: 'Lidická 311/37'
            city: 'Praha 5'
            zip: 15000
            map:
                lat: 50.072111
                lng: 14.405276

    parse: (restaurant, $) ->
        today = moment().format('D.M.YYYY')
        $('article.facility-daily-menu section.daily-menu-for-day').each (i, elem) ->
            if $(this).text().search(today) == -1
                return
            
            soup = $(this).find('section.daily-menu header').first()
            name = soup.find('h3').text().trim()
            price = soup.find('.price').text().trim()
            restaurant.addMeal name, price
            
            $(this).find('section.daily-menu ul li').each (i, elem) ->
                name = $(this).find('.name').text().trim()
                price = $(this).find('.price').text().trim()
                restaurant.addMeal name, price
            return false


module.exports = HlubinaLoader
