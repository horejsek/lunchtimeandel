
cheerio = require 'cheerio'
request = require 'request'

module.exports = (Meal, Restaurant) ->
    class LunchmenuLoader
        constructor: () ->
            @name = undefined
            @url = undefined

        loadData: () ->
            @clearDatabase()
            that = @
            request uri: @url, (err, response, body) ->
                $ = cheerio.load body
                restaurant = new Restaurant()
                restaurant.name = that.name
                restaurant.url = that.url
                restaurant.lastUpdate = new Date()
                that.parse restaurant, $
                restaurant.save()

        clearDatabase: () ->
            Restaurant.collection.drop()

    class TGILoader extends LunchmenuLoader
        constructor: () ->
            @name = 'T.G.I. Friday'
            @url = 'http://www.tgifridays.cz/cs/na-andelu/obedove-menu-andel/'

        parse: (restaurant, $) ->
            $('#articles table tr').each (i, elem) ->
                restaurant.meals.push new Meal 
                    name: $(this).find('td').first().text().trim()
                    price: $(this).find('td').last().text().trim()

    class HusaLoader extends LunchmenuLoader
        constructor: () ->
            @name = 'Potrefená Husa'
            @url = 'http://www.phnaverandach.cz/cz/menu/daily-menu'

        parse: (restaurant, $) ->
            n = (new Date()).getDay()
            $('article table').each (i, elem) ->
                if i+1 is n
                    $(this).find('tr').each (i, elem) ->
                        name = $(this).find('td').first().text().trim() + ' - ' + $(this).find('td').eq(1).text().trim()
                        price = $(this).find('td').last().text().trim()
                        restaurant.meals.push new Meal
                            name: name
                            price: price

    class IlNostroLoader extends LunchmenuLoader
        constructor: () ->
            @name = 'Il Nostro'
            @url = 'http://www.ilnostro.cz/cz/tydenni-menu'

        parse: (restaurant, $) ->
            n = (new Date()).getDay()
            $('.obsah table').each (i, elem) ->
                if i+1 is n
                    $(this).find('tr').each (i, elem) ->
                        restaurant.meals.push new Meal
                            name: $(this).find('td').eq(1).text().trim()
                            price: $(this).find('td').last().text().trim()


    load = () ->
        console.log 'Reloading data...'
        (new TGILoader).loadData()
        (new HusaLoader).loadData()
        (new IlNostroLoader).loadData()
