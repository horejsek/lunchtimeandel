
module.exports = (models) ->
    LunchmenuLoader = require('./lunchmenuLoader')(models)

    class TradiceLoader extends LunchmenuLoader
        constructor: () ->
            @name = 'Tradice'
            @homepage = 'http://www.tradiceandel.cz'
            @downloadUrl = 'http://www.tradiceandel.cz/cz/denni-nabidka/'
            @phoneNumber = '+420 251 550 050'
            @address =
                street: 'Radlická 806/18'
                city: 'Praha 5'
                zip: 15000
                map:
                    lat: 50.06924
                    lng: 14.401515

        parse: (meals, $) ->
            n = (new Date()).getDay()
            $('.separator-section').each (i, elem) ->
                if i+1 is n
                    $(this).find('.item').each (i, elem) ->
                        meals.push new models.Meal
                            name: $(this).find('div').first().text().trim()
                            price: $(this).find('div').last().text().trim()

    return TradiceLoader
