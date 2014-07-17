
moment = require 'moment'

LunchmenuLoader = require './lunchmenuLoader'


class PravekLoader extends LunchmenuLoader
    constructor: () ->
        @name = 'Pravěk'
        @homepage = 'http://www.pravek.cz/'
        @downloadUrl = 'http://www.lunchtime.cz/podnik/487-pravek/denni-menu?format=iframe'
        @phoneNumber = '+420 257 326 908'
        @address =
            street: 'Na Bělidle 40'
            city: 'Praha 5'
            zip: 15000
            map:
                lat: 50.0717091
                lng: 14.4049219

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


module.exports = PravekLoader
