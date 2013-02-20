
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
        goog.events.listen @searchbox_, goog.events.EventType.INPUT, (e) ->
            that.search()

    search: () ->
        keyword = @searchbox_.value.toLowerCase()
        for meal in goog.dom.getElementsByClass 'meal'
            showed = not keyword or meal.innerHTML.toLowerCase().indexOf(keyword) > -1
            goog.dom.classes.enable meal, 'hidemeal', !showed
