
LunchmenuLoader = require './lunchmenuLoader'


class SmichovskyRadnicniSklipekLoader extends LunchmenuLoader
    constructor: () ->
        @name = 'Smíchovský radničnní sklípek'
        @homepage = 'http://www.smichovskysklipek.cz/'
        @downloadUrl = 'https://www.zomato.com/widgets/daily_menu?entity_id=16507625'
        @phoneNumber = '+420 257 000 319'
        @address =
            street: 'Preslova 4'
            city: 'Praha 5'
            zip: 15000
            map:
                lat: 50.072733
                lng: 14.407036

    parse: (restaurant, $) ->
        @lunchmenuParse_ restaurant, $


module.exports = SmichovskyRadnicniSklipekLoader
