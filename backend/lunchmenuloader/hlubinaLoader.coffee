
LunchmenuLoader = require './lunchmenuLoader'


class HlubinaLoader extends LunchmenuLoader
    constructor: () ->
        @name = 'Hlubina'
        @homepage = 'http://www.restaurace-hlubina.cz/'
        @downloadUrl = 'http://www.lunchtime.cz/hlubina/pw/denni-menu/'
        @phoneNumber = '+420 257 328 184'
        @address =
            street: 'Lidická 311/37'
            city: 'Praha 5'
            zip: 15000
            map:
                lat: 50.072111
                lng: 14.405276

    parse: (restaurant, $) ->
        @lunchmenuParse_ restaurant, $


module.exports = HlubinaLoader
