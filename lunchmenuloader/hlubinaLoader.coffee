
module.exports = (models) ->
    LunchmenuLoader = require('./lunchmenuLoader')(models)

    class HlubinaLoader extends LunchmenuLoader
        constructor: () ->
            @name = 'Hlubina'
            @homepage = 'http://www.restaurace-hlubina.cz/'
            @downloadUrl = 'http://www.lunchtime.cz/denni-menu/praha/smichov/'

        parse: (meals, $) ->
            console.log 'asfasdf', $('#restaurace2006')
            $('#restaurace2006 tr').each (i, elem) ->
                meals.push new models.Meal
                    name: $(this).find('td').first().text().trim()
                    price: $(this).find('td').last().text().trim()

    return HlubinaLoader
