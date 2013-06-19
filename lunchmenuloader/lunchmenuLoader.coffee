
cheerio = require 'cheerio'
Iconv  = require('iconv').Iconv
request = require 'request'

module.exports = (models) ->
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
                @loadData_()
            catch e
                console.error e

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
                    that.parse restaurant.meals, $
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

        parse: (meals, $) ->

    return LunchmenuLoader
