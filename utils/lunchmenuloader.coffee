
cheerio = require 'cheerio'
request = require 'request'

module.exports = (models) ->
    class LunchmenuLoader
        constructor: () ->
            @name = undefined
            @url = undefined

        loadData: () ->
            that = @
            request uri: @url, (err, response, body) ->
                $ = cheerio.load body
                restaurant = new models.Restaurant
                    name: that.name
                    url: that.url
                    lastUpdate: new Date()
                that.parse restaurant.meals, $
                restaurant.save()

    class TGILoader extends LunchmenuLoader
        constructor: () ->
            @name = 'T.G.I. Friday'
            @url = 'http://www.tgifridays.cz/cs/na-andelu/obedove-menu-andel/'

        parse: (meals, $) ->
            $('#articles table tr').each (i, elem) ->
                meals.push new models.Meal 
                    name: $(this).find('td').first().text().trim()
                    price: $(this).find('td').last().text().trim()

    class HusaLoader extends LunchmenuLoader
        constructor: () ->
            @name = 'Potrefená Husa'
            @url = 'http://www.phnaverandach.cz/cz/menu/daily-menu'

        parse: (meals, $) ->
            n = (new Date()).getDay()
            $('article table').each (i, elem) ->
                if i+1 is n
                    $(this).find('tr').each (i, elem) ->
                        name = $(this).find('td').first().text().trim() + ' - ' + $(this).find('td').eq(1).text().trim()
                        price = $(this).find('td').last().text().trim()
                        meals.push new models.Meal
                            name: name
                            price: price

    class IlNostroLoader extends LunchmenuLoader
        constructor: () ->
            @name = 'Il Nostro'
            @url = 'http://www.ilnostro.cz/cz/tydenni-menu'

        parse: (meals, $) ->
            n = (new Date()).getDay()
            $('.obsah table').each (i, elem) ->
                if i+1 is n
                    $(this).find('tr').each (i, elem) ->
                        meals.push new models.Meal
                            name: $(this).find('td').eq(1).text().trim()
                            price: $(this).find('td').last().text().trim()


    load = () ->
        console.log 'Reloading data...'
        models.Restaurant.collection.drop()
        (new TGILoader).loadData()
        (new HusaLoader).loadData()
        (new IlNostroLoader).loadData()
