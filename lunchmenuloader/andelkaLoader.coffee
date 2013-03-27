
module.exports = (models) ->
    LunchmenuLoader = require('./lunchmenuLoader')(models)

    class AndelkaLoader extends LunchmenuLoader
        constructor: () ->
            @name = 'Andělka'
            @homepage = 'http://www.andelka.cz'
            @downloadUrl = 'http://www.andelka.cz/denni-menu.php'
            @map =
                lat: 50.06867
                lon: 14.401639

        parse: (meals, $) ->
            $('#container tbody tr').each (i, elem) ->
                name = $(this).find('td').eq(1).text().trim()
                price = $(this).find('td').last().text().trim()
                if name
                    meals.push new models.Meal
                        name: name
                        price: price

    return AndelkaLoader
