
module.exports = (models) ->
    LunchmenuLoader = require('./lunchmenuLoader')(models)

    class HusaLoader extends LunchmenuLoader
        constructor: () ->
            @name = 'Potrefená Husa (Anděl)'
            @homepage = 'http://www.staropramen.cz/husa/restaurace-praha-andel/denni-menu'
            @downloadUrl = 'http://www.staropramen.cz/husa/restaurace-praha-andel/denni-menu'
            @map =
                lat: 50.070479
                lon: 14.404525

        parse: (meals, $) ->
            $('#denniMenuCarousel li').first().find('li').each (i, elem) ->
                meals.push new models.Meal
                    name: $(this).find('.name').text().trim()
                    price: $(this).find('.price').text().trim()

    return HusaLoader
