
moment = require 'moment'

LunchmenuLoader = require './lunchmenuLoader'

class UBilehoLvaLoader extends LunchmenuLoader
    constructor: () ->
        @name = 'U Bílého lva'
        @homepage = 'http://www.ubileholva.com'
        @downloadUrl = 'https://www.zomato.com/cs/widgets/daily_menu?entity_id=16512685'
        @phoneNumber = '+420 257 316 731'
        @address =
            street: 'Na Bělidle 310/30'
            city: 'Praha 5'
            zip: 15000
            map:
                lat: 50.071753
                lng: 14.405973

    parse: (restaurant, $) ->
        @lunchmenuParse_ restaurant, $


module.exports = UBilehoLvaLoader
