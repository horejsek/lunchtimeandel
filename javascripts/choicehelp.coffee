
goog.provide 'lta.ChoiceHelp'

goog.require 'goog.dom'
goog.require 'goog.events'
goog.require 'goog.net.XhrIo'


class lta.ChoiceHelp
    ###*
    @type {?number}
    @private
    ###
    timeout: null

    constructor: () ->
        @initListeners()

    ###*
    @private
    ###
    initListeners: () ->
        that = @

        callback = () -> that.help()
        @timeout = setTimeout callback, 10*60*1000
        linkElm = goog.dom.getElement 'choicehelp-link'
        goog.events.listen linkElm, goog.events.EventType.CLICK, (e) ->
            if window['_gaq']
                window['_gaq'].push ['_trackEvent', 'Random', 'ShowByClick']
            that.help()

        closeElm = goog.dom.getElement 'choicehelp-close'
        goog.events.listen closeElm, goog.events.EventType.CLICK, (e) ->
            that.hide()
        goog.events.listen window.document, goog.events.EventType.KEYUP, (e) ->
            that.hide() if e.keyCode is goog.events.KeyCodes.ESC

    help: () ->
        # When user clicks on random, do not show random after XY minutes.
        window.clearTimeout @timeout

        if window['_gaq']
            window['_gaq'].push ['_trackEvent', 'Random', 'Show']

        goog.net.XhrIo.send '/api/meal/random', (e) ->
            res = e.target.getResponseJson()

            elm = soy.renderAsElement lta.templates.random,
                restaurant:
                    id: res['restaurant']['id']
                    name: res['restaurant']['name']
                meal:
                    name: res['meal']['name']
                    priceStr: res['meal']['priceStr']
            goog.dom.replaceNode elm, goog.dom.getElement 'choicehelp-text'

            boxElm = goog.dom.getElement 'choicehelp-box'
            goog.dom.classes.remove boxElm, 'hide'

    hide: () ->
        boxElm = goog.dom.getElement 'choicehelp-box'
        goog.dom.classes.add boxElm, 'hide'


window['lta'] = lta
lta['ChoiceHelp'] = lta.ChoiceHelp
