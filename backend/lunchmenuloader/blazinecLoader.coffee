
LunchmenuLoader = require './lunchmenuLoader'


class BlazinecLoader extends LunchmenuLoader
    constructor: () ->
        @name = 'Blázinec'
        @homepage = 'http://www.blazinecandel.cz/'
        @downloadUrl = 'https://www.zomato.com/cs/widgets/daily_menu?entity_id=16506661'
        @phoneNumber = '+420 257 316 655'
        @address =
            street: 'Nádražní 59/112'
            city: 'Praha 5'
            zip: 15000
            map:
                lat: 50.070851
                lng: 14.405109

    parse: (restaurant, $) ->
        @lunchmenuParse_ restaurant, $


module.exports =  BlazinecLoader
