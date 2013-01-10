
module.exports = (models) ->
    LunchmenuLoader = require('./lunchmenuLoader')(models)

    class UBilehoLvaLoader extends LunchmenuLoader
        constructor: () ->
            @name = 'U Bílého lva'
            @homepage = 'http://www.ubileholva.com'
            @downloadUrl = 'http://www.ubileholva.com/index.cfm/co-bude-dnes-k-obedu/'

    return UBilehoLvaLoader
