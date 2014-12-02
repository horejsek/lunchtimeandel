
LunchmenuLoader = require './lunchmenuLoader'


class PeronLoader extends LunchmenuLoader
    constructor: () ->
        @name = 'Perón'
        @homepage = 'http://www.peronsmichov.cz/'
        @downloadUrl = 'https://www.zomato.com/widgets/daily_menu?entity_id=16506659'
        @phoneNumber = '+420 602 741 401'
        @address =
            street: 'Stroupežnického 20'
            city: 'Praha 5'
            zip: 15000
            map:
                lat: 50.0707348
                lng: 14.4031405

    parse: (restaurant, $) ->
        @lunchmenuParse_ restaurant, $


module.exports = PeronLoader
