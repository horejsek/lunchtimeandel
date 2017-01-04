
LunchmenuLoader = require './lunchmenuLoader'


class FormankaLoader extends LunchmenuLoader
    constructor: () ->
        @name = 'Smíchovská Formanka'
        @homepage = 'http://www.smichovskaformanka.cz/'
        @downloadUrl = 'https://www.zomato.com/cs/widgets/daily_menu?entity_id=16506447'
        @phoneNumber = '+420 251 560 099'
        @address =
            street: 'Ostrovského 411/24'
            city: 'Praha 5'
            zip: 15000
            map:
                lat: 50.068636
                lng: 14.400936

    parse: (restaurant, $) ->
        @lunchmenuParse_ restaurant, $


module.exports = FormankaLoader
