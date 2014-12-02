
LunchmenuLoader = require './lunchmenuLoader'


class PravekLoader extends LunchmenuLoader
    constructor: () ->
        @name = 'Pravěk'
        @homepage = 'http://www.pravek.cz/'
        @downloadUrl = 'https://www.zomato.com/widgets/daily_menu?entity_id=16505924'
        @phoneNumber = '+420 257 326 908'
        @address =
            street: 'Na Bělidle 40'
            city: 'Praha 5'
            zip: 15000
            map:
                lat: 50.0717091
                lng: 14.4049219

    parse: (restaurant, $) ->
        @lunchmenuParse_ restaurant, $


module.exports = PravekLoader
