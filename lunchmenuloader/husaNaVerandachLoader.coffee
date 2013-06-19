
module.exports = (models) ->
    LunchmenuLoader = require('./lunchmenuLoader')(models)

    class HusaNaVerandachLoader extends LunchmenuLoader
        constructor: () ->
            @name = 'Potrefená Husa (na Verandách)'
            @homepage = 'http://www.phnaverandach.cz/'
            @downloadUrl = 'http://www.phnaverandach.cz/cz/menu/daily-menu'
            @phoneNumber = '+420 257 191 200'
            @address =
                street: 'Nádražní 43/84'
                city: 'Praha 5'
                zip: 15000
                map:
                    lat: 50.068493
                    lng: 14.406593

        parse: (meals, $) ->
            n = (new Date()).getDay()
            $('article table').each (i, elem) ->
                if i+1 is n
                    $(this).find('tr').each (i, elem) ->
                        name = $(this).find('td').first().text().trim() + ' - ' + $(this).find('td').eq(1).text().trim()
                        price = $(this).find('td').last().text().trim()
                        meals.push new models.Meal
                            name: name
                            price: price

    return HusaNaVerandachLoader
