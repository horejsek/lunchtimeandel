
LunchmenuLoader = require './lunchmenuLoader'


class PeronLoader extends LunchmenuLoader
    constructor: () ->
        @name = 'U perónu'
        @homepage = 'http://www.uperonu.cz/'
        @downloadUrl = 'http://www.uperonu.cz/jidelni-listek/tydenni-menu-1100-1500.html'
        @phoneNumber = '+420 721 441 440'
        @address =
            street: 'Nádražní 40'
            city: 'Praha 5'
            zip: 15000
            map:
                lat: 50.069773
                lng: 14.405764

    parse: (restaurant, $) ->


module.exports = PeronLoader

# http://www.uperonu.cz/jidelni-listek/tydenni-menu-1100-1500/75-steda.html
# http://www.uperonu.cz/jidelni-listek/tydenni-menu-1100-1500/58-tvrtek-2110-2011.html
# http://www.uperonu.cz/jidelni-listek/tydenni-menu-1100-1500/76-patek.html
