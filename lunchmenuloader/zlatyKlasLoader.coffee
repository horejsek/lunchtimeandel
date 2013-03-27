
module.exports = (models) ->
    LunchmenuLoader = require('./lunchmenuLoader')(models)

    class ZlatyKlasLoader extends LunchmenuLoader
        constructor: () ->
            @name = 'Zlatý Klas'
            @homepage = 'http://www.zlatyklas.cz'
            @downloadUrl = 'http://www.zlatyklas.cz/index.php?sec=today-menu&lang=cz'
            @charset = 'CP1250'
            @map =
                lat: 50.071636
                lon: 14.400287

        parse: (meals, $) ->
            $('.jidelak div.today h2.today').each (i, elem) ->
                meals.push new models.Meal
                    name: $(this).find('span').first().text().trim()
                    price: $(this).find('span').last().text().trim()

    return ZlatyKlasLoader
