
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
                restaurant = new models.Restaurant
                    name: that.name
                    url: that.homepage
                    lastUpdate: new Date()
                that.parse restaurant.meals, $
                restaurant.save()

        convertToUtf8: (body) ->
            charset = @charset || 'UTF8'
            body = new Buffer body, 'binary'
            iconv = new Iconv charset, 'UTF8'
            body = iconv.convert(body).toString()

        parse: (meals, $) ->

    return LunchmenuLoader 
