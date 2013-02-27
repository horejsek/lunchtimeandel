
goog.provide 'lta.Search'

goog.require 'goog.dom'
goog.require 'goog.dom.query'
goog.require 'goog.events'
goog.require 'goog.events.KeyCodes'


class lta.Search
    ###*
    @type {Object}
    @private
    ###
    searchinput_: null

    ###*
    @param {string} searchboxId
    @constructor
    ###
    constructor: (searchboxId) ->
        that = @
        searchbox = goog.dom.getElement searchboxId
        @searchinput_ = goog.dom.getElementsByTagNameAndClass('input', null, searchbox)[0]
        searchbutton = goog.dom.getElementsByTagNameAndClass('button', null, searchbox)[0]

        @searchinput_.focus()
        goog.events.listen @searchinput_, goog.events.EventType.INPUT, (e) ->
            that.search()
        goog.events.listen @searchinput_, goog.events.EventType.KEYUP, (e) ->
            that.clear() if e.keyCode is goog.events.KeyCodes.ESC
        goog.events.listen searchbutton, goog.events.EventType.CLICK, (e) ->
            that.clear()

    clear: () ->
        @searchinput_.value = ''
        @searchinput_.focus()
        # Remove highlight, show restaurant, ...
        @search()

    search: () ->
        keyword = @searchinput_.value
        pattern = new RegExp keyword, 'gi'
        @removeHighlight_()
        for meal in goog.dom.getElementsByClass 'meal'
            showed = not keyword or meal.innerHTML.search(pattern) > -1
            @highlight_(meal) if showed and keyword
            goog.dom.classes.enable meal.parentNode, 'hide', !showed
        @showHideRestaurants_()

    ###*
    @private
    ###
    highlight_: (meal) ->
        content = meal.innerHTML
        pattern = new RegExp '(.*)(' + @searchinput_.value + ')(.*)', 'gi'
        replaceWith = '$1<span class="highlight label label-warning">$2</span>$3'
        meal.innerHTML = content.replace pattern, replaceWith

    ###*
    @private
    ###
    removeHighlight_: () ->
        for elm in goog.dom.getElementsByClass 'highlight'
            text = goog.dom.createTextNode goog.dom.getTextContent elm
            goog.dom.replaceNode text, elm

    ###*
    @private
    ###
    showHideRestaurants_: () ->
        for restaurant in goog.dom.getElementsByClass 'restaurant'
            meals = goog.dom.query 'tr:not(.hide)', restaurant
            goog.dom.classes.enable restaurant, 'hide', !meals.length
