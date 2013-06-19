
module.exports = (models) ->
    LunchmenuLoader = require('./lunchmenuLoader')(models)

    class AndelkaLoader extends LunchmenuLoader
        constructor: () ->
            @name = 'U Žíznivého jelena'
            @homepage = 'http://www.uziznivehojelena.cz/'
            @downloadUrl = 'http://www.uziznivehojelena.cz/poledni-menu'
            @phoneNumber = '+420 257 322 525'
            @address =
                street: 'Vltavská 523/15'
                city: 'Praha 5'
                zip: 15000
                map:
                    lat: 50.069632
                    lng: 14.406402

        parse: (meals, $) ->
            callback = (i, elem) ->
                meals.push new models.Meal
                    name: $(this).find('td').first().text().trim()
                    price: $(this).find('td').last().text().trim()
            $('#content').find('table').eq(0).find('tr').each callback # soup
            $('#content').find('table').eq(1).find('tr').each callback # daily menu
            $('#content').find('table').eq(2).find('tr').each callback # week menu

    return AndelkaLoader
