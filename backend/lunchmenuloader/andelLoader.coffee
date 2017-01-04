
LunchmenuLoader = require './lunchmenuLoader'


class AndelLoader extends LunchmenuLoader
    constructor: () ->
        @name = 'Anděl'
        @homepage = 'http://www.restauraceandel.cz'
        @downloadUrl = 'https://www.zomato.com/cs/widgets/daily_menu?entity_id=16507310'
        @phoneNumber = '+420 257 323 234'
        @address =
            street: 'Nádražní 114'
            city: 'Praha 5'
            zip: 15000
            map:
                lat: 50.070985
                lng: 14.404854

    parse: (restaurant, $) ->
        @lunchmenuParse_ restaurant, $


module.exports = AndelLoader
