
module.exports = (models) ->
    LunchmenuLoader = require('./lunchmenuLoader')(models)

    class LaCambusaLoader extends LunchmenuLoader
        constructor: () ->
            @name = 'La Cambusa'
            @homepage = 'http://www.lacambusa.cz'
            @downloadUrl = 'http://www.lacambusa.cz/jidelni-listek'

        parse: (meals, $) ->
            n = (new Date()).getDay()
            $('.roktabs-tab' + n + ' p').each (i, elem) ->
                row = $(this).text().trim()
                if not row
                    return
                row = row.split /\(?=[0-9 ]+,-)/
                meals.push new models.Meal
                    name: row[0]
                    price: row[1]

    return LaCambusaLoader
