
moment = require 'moment'

LunchmenuLoader = require './lunchmenuLoader'


class PizzerieMediteraneLoader extends LunchmenuLoader
    constructor: () ->
        @name = 'Pizzerie Mediterane'
        @homepage = 'http://www.pizzeriemediterane.cz'
        @downloadUrl = 'http://www.lunchtime.cz/pizzerie-mediterane/pw/denni-menu/'
        @phoneNumber = '+420 257 320 579'
        @address =
            street: 'Radlická 3179/1e'
            city: 'Praha 5'
            zip: 15000
            map:
                lat: 50.071295
                lng: 14.40159

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


module.exports = PizzerieMediteraneLoader
