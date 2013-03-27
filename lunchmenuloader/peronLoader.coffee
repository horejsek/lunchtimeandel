
module.exports = (models) ->
    LunchmenuLoader = require('./lunchmenuLoader')(models)

    class PeronLoader extends LunchmenuLoader
        constructor: () ->
            @name = 'U perónu'
            @homepage = 'http://www.uperonu.cz/'
            @downloadUrl = 'http://www.uperonu.cz/jidelni-listek/tydenni-menu-1100-1500.html'
            @map =
                lat: 50.069773
                lon: 14.405764

        parse: (meals, $) ->

    return PeronLoader

# http://www.uperonu.cz/jidelni-listek/tydenni-menu-1100-1500/75-steda.html
# http://www.uperonu.cz/jidelni-listek/tydenni-menu-1100-1500/58-tvrtek-2110-2011.html
# http://www.uperonu.cz/jidelni-listek/tydenni-menu-1100-1500/76-patek.html
