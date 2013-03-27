
module.exports = (models) ->
    LunchmenuLoader = require('./lunchmenuLoader')(models)

    class JetSetLoader extends LunchmenuLoader
        constructor: () ->
            @name = 'Jet Set'
            @homepage = 'http://www.jetset.cz/'
            @downloadUrl = 'http://www.docservis.cz/jetset/www/cs/home/daily-menu'
            @map =
                lat: 50.071646
                lon: 14.401585

        parse: (meals, $) ->
            $('tbody tr').each (i, elem) ->
                row = $(this).text().trim().split /\ (?=[0-9 ]+,-)/
                meals.push new models.Meal
                    name: row[0]
                    price: row[1]

    return JetSetLoader
