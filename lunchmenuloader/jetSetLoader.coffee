
module.exports = (models) ->
    LunchmenuLoader = require('./lunchmenuLoader')(models)

    class JetSetLoader extends LunchmenuLoader
        constructor: () ->
            @name = 'Jet Set'
            @homepage = 'http://www.jetset.cz/'
            @downloadUrl = 'http://www.docservis.cz/jetset/www/cs/home/daily-menu'
            @phoneNumber = '+420 257 327 251'
            @address =
                street: 'Radlická 3185/1C'
                city: 'Praha 5'
                zip: 15000
                map:
                    lat: 50.071646
                    lng: 14.401585

        parse: (meals, $) ->
            $('tbody tr').each (i, elem) ->
                row = $(this).text().trim().split /\ (?=[0-9 ]+,-)/
                meals.push new models.Meal
                    name: row[0]
                    price: row[1]

    return JetSetLoader
