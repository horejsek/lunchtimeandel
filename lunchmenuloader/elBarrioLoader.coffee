
module.exports = (models) ->
    LunchmenuLoader = require('./lunchmenuLoader')(models)

    class ElBarrioLoader extends LunchmenuLoader
        constructor: () ->
            @name = 'El Barrio de Ángel'
            @homepage = 'http://www.elbarrio.cz/'
            @downloadUrl = 'http://www.elbarrio.cz/index.php?option=com_phocamenu&view=dailymenu'
            @phoneNumber = '+420 725 535 555'
            @address =
                street: 'Lidická 284/42'
                city: 'Praha 5'
                zip: 15000
                map:
                    lat: 50.072173
                    lng: 14.404519

        parse: (meals, $) ->
            $('.pm-item tr').each (i, elem) ->
                row = $(this).text().trim()
                if not row
                    return
                quantity = $(this).find('td.pmquantity').text().trim()
                name = $(this).find('td.pmtitle').text().trim()
                price = $(this).find('td.pmprice').text().trim()
                meals.push new models.Meal
                    name: quantity + ' ' + name
                    price: price

    return ElBarrioLoader
