
module.exports = (models) ->
    LunchmenuLoader = require('./lunchmenuLoader')(models)

    class TGILoader extends LunchmenuLoader
        constructor: () ->
            @name = 'T.G.I. Friday'
            @homepage = 'http://www.tgifridays.cz/cs/na-andelu/'
            @downloadUrl = 'http://www.tgifridays.cz/cs/na-andelu/obedove-menu-andel/'

        parse: (meals, $) ->
            $('#articles table tr').each (i, elem) ->
                meals.push new models.Meal 
                    name: $(this).find('td').first().text().trim()
                    price: $(this).find('td').last().text().trim()

    return TGILoader
