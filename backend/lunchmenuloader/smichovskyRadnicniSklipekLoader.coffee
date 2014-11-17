
moment = require 'moment'

LunchmenuLoader = require './lunchmenuLoader'


class SmichovskyRadnicniSklipekLoader extends LunchmenuLoader
    constructor: () ->
        @name = 'Smíchovský radničnní sklípek'
        @homepage = 'http://www.smichovskysklipek.cz/'
        @downloadUrl = 'http://www.lunchtime.cz/smichovsky_sklipek/pw/denni-menu/'
        @phoneNumber = '+420 257 000 319'
        @address =
            street: 'Preslova 4'
            city: 'Praha 5'
            zip: 15000
            map:
                lat: 50.072733
                lng: 14.407036

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


module.exports = SmichovskyRadnicniSklipekLoader
