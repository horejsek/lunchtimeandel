
goog.provide 'lta.Search'

goog.require 'goog.dom'
goog.require 'goog.events'


class lta.Search
    ###*
    @type {Object}
    @private
    ###
    searchbox_: null

    ###*
    @param {string} searchboxId
    @constructor
    ###
    constructor: (searchboxId) ->
        that = @
        @searchbox_ = goog.dom.getElement searchboxId
        @searchbox_.focus()
        goog.events.listen @searchbox_, goog.events.EventType.INPUT, (e) ->
            that.search()

    search: () ->
        keyword = @searchbox_.value
        pattern = new RegExp keyword, 'gi'
        @removeHighlight_()
        for meal in goog.dom.getElementsByClass 'meal'
            showed = not keyword or meal.innerHTML.search(pattern) > -1
            @highlight_(meal) if showed and keyword
            goog.dom.classes.enable meal.parentNode, 'hide', !showed

    ###*
    @private
    ###
    highlight_: (meal) ->
        content = meal.innerHTML
        pattern = new RegExp '(.*)(' + @searchbox_.value + ')(.*)', 'gi'
        replaceWith = '$1<span class="highlight label label-warning">$2</span>$3'
        meal.innerHTML = content.replace pattern, replaceWith

    ###*
    @private
    ###
    removeHighlight_: () ->
        for elm in goog.dom.getElementsByClass 'highlight'
            text = goog.dom.createTextNode goog.dom.getTextContent elm
            goog.dom.replaceNode text, elm
