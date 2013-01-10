
module.exports = (models) ->
    LunchmenuLoader = require('./lunchmenuLoader')(models)

    class IlNostroLoader extends LunchmenuLoader
        constructor: () ->
            @name = 'Il Nostro'
            @homepage = 'http://www.ilnostro.cz'
            @downloadUrl = 'http://www.ilnostro.cz/cz/tydenni-menu'

        parse: (meals, $) ->
            n = (new Date()).getDay()
            $('.obsah table').each (i, elem) ->
                if i+1 is n
                    $(this).find('tr').each (i, elem) ->
                        meals.push new models.Meal
                            name: $(this).find('td').eq(1).text().trim()
                            price: $(this).find('td').last().text().trim()

    return IlNostroLoader
