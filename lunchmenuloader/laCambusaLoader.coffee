
module.exports = (models) ->
    LunchmenuLoader = require('./lunchmenuLoader')(models)

    class LaCambusaLoader extends LunchmenuLoader
        constructor: () ->
            @name = 'La Cambusa'
            @homepage = 'http://www.lacambusa.cz'
            @downloadUrl = 'http://www.lacambusa.cz/jidelni-listek'
            @phoneNumber = '+420 240 200 218'
            @address =
                street: 'Stroupežnického 9'
                city: 'Praha 5'
                zip: 15000
                map:
                    lat: 50.06976
                    lng: 14.402803

        parse: (meals, $) ->
            n = (new Date()).getDay()
            $('.roktabs-tab' + n + ' p').each (i, elem) ->
                row = $(this).text().trim()
                if not row
                    return
                row = row.split /\ (?=[0-9 ]+,-)/
                meals.push new models.Meal
                    name: row[0]
                    price: row[1]

    return LaCambusaLoader
