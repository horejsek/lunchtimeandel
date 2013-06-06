
moment = require 'moment'

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
            today = moment().format('DD. MM. YYYY')
            $('.today-menu').each (i, elem) ->
                if $(this).find('h2').text().search(today) == -1
                    return
                $(this).find('td.popisJidla').each (i, elem) ->
                    meals.push new models.Meal
                        name: $(this).text().trim()

    return SodexoLoader
