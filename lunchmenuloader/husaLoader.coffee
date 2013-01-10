
module.exports = (models) ->
    LunchmenuLoader = require('./lunchmenuLoader')(models)

    class HusaLoader extends LunchmenuLoader
        constructor: () ->
            @name = 'Potrefená Husa'
            @homepage = 'http://www.phnaverandach.cz/'
            @downloadUrl = 'http://www.phnaverandach.cz/cz/menu/daily-menu'

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

    return HusaLoader
