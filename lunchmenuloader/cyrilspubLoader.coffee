
module.exports = (models) ->
    LunchmenuLoader = require('./lunchmenuLoader')(models)

    class CyrilspubLoader extends LunchmenuLoader
        constructor: () ->
            @name = 'CYRIL\'s pub'
            @homepage = 'http://www.cyrilspub.cz/'
            @downloadUrl = 'http://www.cyrilspub.cz/denni-menu/'
            @map =
                lat: 50.070276
                lon: 14.403237

        parse: (meals, $) ->
            $('table').first().find('tr').each (i, elem) ->
                meals.push new models.Meal
                    name: $(this).find('td').first().text().trim()
                    price: $(this).find('td').last().text().trim()

    return CyrilspubLoader
