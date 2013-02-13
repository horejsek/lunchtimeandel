
cheerio = require 'cheerio'
Iconv  = require('iconv').Iconv
request = require 'request'

module.exports = (models) ->
    class LunchmenuLoader
        constructor: () ->
            @name = undefined
            @homepage = undefined
            @downloadUrl = undefined

        loadData: () ->
            that = @
            foo =
                uri: @downloadUrl
                encoding: 'binary'
            request foo, (err, response, body) ->
                body = that.convertToUtf8 body
                $ = cheerio.load body
                that.restaurant = restaurant = that.createRestaurant()
                that.parse restaurant.meals, $
                restaurant.save()

        createRestaurant: () ->
            new models.Restaurant
                name: @name
                url: @homepage
                lastUpdate: new Date()

        convertToUtf8: (body) ->
            charset = @charset || 'UTF8'
            body = new Buffer body, 'binary'
            iconv = new Iconv charset, 'UTF8'
            body = iconv.convert(body).toString()

        parse: (meals, $) ->

    return LunchmenuLoader 
