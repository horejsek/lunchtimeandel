
cheerio = require 'cheerio'
Iconv = require('iconv').Iconv
moment = require 'moment'
request = require 'request'

models = require '../models'


class LunchmenuLoader
    constructor: () ->
        @name = undefined
        @homepage = undefined
        @downloadUrl = undefined
        @address = undefined
        @phoneNumber = undefined
        @charset = undefined

    loadData: () ->
        try
            console.log 'Loading data for ', @name
            @loadData_()
            console.log 'Loaded data for ', @name
        catch e
            console.error 'Error during loading data for', @name, e

    loadData_: () ->
        that = @
        options =
            uri: @downloadUrl
            encoding: 'binary'
            # make the request look like it's from common user agent
            headers:
                'User-Agent': '  Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.1; Trident/6.0)'
                'Accept-Language': 'cs,en;q=0.8,en-US;q=0.6,sk;q=0.4'
                'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
        request options, (err, response, body) ->
            try
                body = that.convertToUtf8 body
                $ = cheerio.load body
                that.restaurant = restaurant = that.createRestaurant()
                that.parse restaurant, $
                restaurant.save()
            catch e
                console.error e

    createRestaurant: () ->
        new models.Restaurant
            name: @name
            urls:
                homepage: @homepage
                lunchmenu: @downloadUrl
            lastUpdate: new Date()
            phoneNumber: @phoneNumber
            address: @address

    convertToUtf8: (body) ->
        charset = @charset || 'UTF8'
        body = new Buffer body, 'binary'
        iconv = new Iconv charset, 'UTF8'
        body = iconv.convert(body).toString()

    parse: (restaurant, $) ->
        
    lunchmenuParse_: (restaurant, $) ->
        today = moment().format(', DD ')
        $('.date').each (i, elem) ->
            if $(this).text().search(today) == -1
                return

            $(this).nextUntil('.date, .divider', '.item').each (i, elem) ->
                name = $(this).find('.item-name').text().trim()
                desc = $(this).find('.item-description').text().trim()
                price = $(this).find('.item-price').text().trim()
                if name and price
                    restaurant.addMeal name + ': ' + desc, price
            return false


module.exports = LunchmenuLoader
