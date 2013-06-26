
goog.provide 'lta.ChoiceHelp'

goog.require 'goog.dom'
goog.require 'goog.events'
goog.require 'goog.net.XhrIo'


class lta.ChoiceHelp
    constructor: () ->
        @initListeners_()

    ###*
    @private
    ###
    initListeners_: () ->
        that = @

        callback = () -> that.help()
        setTimeout callback, 10*60*1000
        linkElm = goog.dom.getElement 'choicehelp-link'
        goog.events.listen linkElm, goog.events.EventType.CLICK, callback

        closeElm = goog.dom.getElement 'choicehelp-close'
        goog.events.listen closeElm, goog.events.EventType.CLICK, () -> that.hide()

    help: () ->
        goog.net.XhrIo.send '/api/meal/random', (e) ->
            res = e.target.getResponseJson()

            textElm = goog.dom.getElement 'choicehelp-text'
            textElm.innerHTML = '<strong>' + res['restaurant']['name'] + '</strong>' + ' – ' + res['meal']['name'] + ' (' + res['meal']['priceStr'] + ')'

            boxElm = goog.dom.getElement 'choicehelp-box'
            goog.dom.classes.remove boxElm, 'hide'

    hide: () ->
        boxElm = goog.dom.getElement 'choicehelp-box'
        goog.dom.classes.add boxElm, 'hide'


window['lta'] = lta
lta['ChoiceHelp'] = lta.ChoiceHelp
