
module.exports = (models) ->
    LunchmenuLoader = require('./lunchmenuLoader')(models)

    class FormankaLoader extends LunchmenuLoader
        constructor: () ->
            @name = 'Smíchovská Formanka'
            @homepage = 'http://www.smichovskaformanka.cz/'
            @downloadUrl = 'http://www.smichovskaformanka.cz/poledni_menu.htm'
            @charset = 'CP1250'

        parse: (meals, $) ->
            $('table tr').each (i, elem) ->
                row = $(this).text().trim()
                if not row or $(this).find('td').length < 2
                    return
                name = $(this).find('td').eq(0).text().trim()
                if $(this).find('td').length == 3
                    name += ' ' + $(this).find('td').eq(1).text().trim()
                meals.push new models.Meal
                    name: name
                    price: $(this).find('td').last().text().trim()

    return FormankaLoader
