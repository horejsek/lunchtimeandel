
module.exports = (models) ->
    LunchmenuLoader = require('./lunchmenuLoader')(models)

    class SodexoLoader extends LunchmenuLoader
        constructor: () ->
            @name = 'Firemní restaurace Sodexo'
            @homepage = 'http://mafra.portal.sodexo.cz/cs/uvod'
            @downloadUrl = 'http://mafra.portal.sodexo.cz/cs/jidelni-listek-na-cely-tyden'
            @map =
                lat: 50.069842
                lon: 14.400818

        parse: (meals, $) ->
            n = (new Date()).getDay()
            if n > 5 or n < 1
                return
            n = Math.abs(n - 5)
            $('#menu-' + n + ' td.popisJidla').each (i, elem) ->
                meals.push new models.Meal
                    name: $(this).text().trim()

    return SodexoLoader
