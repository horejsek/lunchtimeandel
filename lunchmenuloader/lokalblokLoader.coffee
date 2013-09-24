
moment = require 'moment'

module.exports = (models) ->
    LunchmenuLoader = require('./lunchmenuLoader')(models)

    class LokalblokLoader extends LunchmenuLoader
        constructor: () ->
            @name = 'Lokal blok'
            @homepage = 'http://lokalblok.cz/restaurace/'
            @downloadUrl = 'http://www.lunchtime.cz/lokal-blok/pw/denni-menu/'
            @phoneNumber = '+420 251 511 490'
            @address =
                street: 'Nám. 14. října 10'
                city: 'Praha 5'
                zip: 15000
                map:
                    lat: 50.073004
                    lng: 14.405016

        parse: (meals, $) ->
            today = moment().format('YYYY-MM-DD')
            $('#restDailyMenu'+today+'Ajax tr').each (i, elem) ->
                meals.push new models.Meal
                    name: $(this).find('td').first().text().trim()
                    price: $(this).find('td').last().text().trim()

    return LokalblokLoader
