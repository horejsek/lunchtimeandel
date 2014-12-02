
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
        foo =
            uri: @downloadUrl
            encoding: 'binary'
        request foo, (err, response, body) ->
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
        $('.tmi-groups .tmi-group').each (i, elem) ->
            if $(this).text().search(today) == -1
                return

            $(this).find('.tmi-daily').each (i, elem) ->
                name = $(this).find('.tmi-name').text().trim()
                desc = $(this).find('.tmi-desc').text().trim()
                price = $(this).find('.tmi-price').text().trim()
                if name and price
                    restaurant.addMeal name + ': ' + desc, price
            return false


module.exports = LunchmenuLoader
