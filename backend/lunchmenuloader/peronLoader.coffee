
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
                lat: 50.0707348
                lng: 14.4031405

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


module.exports = PeronLoader
