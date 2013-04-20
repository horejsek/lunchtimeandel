
module.exports = (models) ->
    LunchmenuLoader = require('./lunchmenuLoader')(models)

    class BlazinecLoader extends LunchmenuLoader
        constructor: () ->
            @name = 'Blázinec'
            @homepage = 'http://www.blazinecandel.cz/'
            @downloadUrl = 'http://www.blazinecandel.cz/denni-menu/'
            @map =
                lat: 50.070851
                lon: 14.405109

        parse: (meals, $) ->
            $('.text').find('table').first().find('tr').each (i, elm) ->
                meals.push new models.Meal
                    name: $(this).find('td').first().text().trim()
                    price: $(this).find('td').last().text().trim()

    return BlazinecLoader
