
cheerio = require 'cheerio'
request = require 'request'

db = require('../db').connection
Meal = require('../models').Meal
Restaurant = require('../models').Restaurant
Restaurants = require('../models').Restaurants


class LunchmenuLoader
    load: (restaurantName, url) ->
        that = @
        request uri: url, (err, response, body) ->
            $ = cheerio.load body
            restaurant = new Restaurant db, restaurantName, url
            that.parse restaurant, $
            restaurant.save()

class TGILoader extends LunchmenuLoader
    parse: (restaurant, $) ->
        $('#articles table tr').each (i, elem) ->
            name = $(this).find('td').first().text().trim()
            price = $(this).find('td').last().text().trim()
            restaurant.addMeal new Meal name, price

class HusaLoader extends LunchmenuLoader
    parse: (restaurant, $) ->
        n = (new Date()).getDay()
        $('article table').each (i, elem) ->
            if i+1 is n
                $(this).find('tr').each (i, elem) ->
                    name = $(this).find('td').first().text().trim() + ' - ' + $(this).find('td').eq(1).text().trim()
                    price = $(this).find('td').last().text().trim()
                    restaurant.addMeal new Meal name, price

class IlNostroLoader extends LunchmenuLoader
    parse: (restaurant, $) ->
        n = (new Date()).getDay()
        $('.obsah table').each (i, elem) ->
            if i+1 is n
                $(this).find('tr').each (i, elem) ->
                    name = $(this).find('td').eq(1).text().trim()
                    price = $(this).find('td').last().text().trim()
                    restaurant.addMeal new Meal name, price


exports.load = () ->
    r = new Restaurants db
    r.clear()
    (new TGILoader).load 'T.G.I. Friday', 'http://www.tgifridays.cz/cs/na-andelu/obedove-menu-andel/'
    (new HusaLoader).load 'Potrefená Husa', 'http://www.phnaverandach.cz/cz/menu/daily-menu'
    (new IlNostroLoader).load 'Il Nostro', 'http://www.ilnostro.cz/cz/tydenni-menu'
