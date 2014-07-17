
moment = require 'moment'

LunchmenuLoader = require './lunchmenuLoader'


class LokalblokLoader extends LunchmenuLoader
    constructor: () ->
        @name = 'Lokal blok'
        @homepage = 'http://lokalblok.cz/restaurace/'
        @downloadUrl = 'http://www.lunchtime.cz/lokal-blok/pw/denni-menu/'
        @phoneNumber = '+420 251 511 490'
        @address =
            street: 'Nám. 14. října 10'
            city: 'Praha 5'
            zip: 15000
            map:
                lat: 50.073004
                lng: 14.405016

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


module.exports = LokalblokLoader
