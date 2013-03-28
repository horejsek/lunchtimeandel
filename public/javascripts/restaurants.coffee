
goog.provide 'lta.Restaurants'

goog.require 'goog.dom'
goog.require 'goog.History'
goog.require 'lta.Restaurant'


class lta.Restaurants
    ###*
    @type {Array}
    @private
    ###
    restaurants_: []

    ###*
    @type {goog.History}
    ###
    history_: null

    ###*
    @param {string} name
    @param {Object} coordinates
    @constructor
    ###
    constructor: (name, coordinates) ->
        that = @
        @history_ = new goog.History()
        @history_.setEnabled true
        goog.events.listen @history_, goog.history.EventType.NAVIGATE, (e) -> that.historyNavigate_ e

    ###*
    @private
    ###
    historyNavigate_: (e) ->
        for restaurant in @restaurants_
            if e.token is restaurant.name then restaurant.mark() else restaurant.unmark()

    ###*
    @param {string} name
    @param {Object} coordinates
    @expose
    ###
    add: (name, coordinates) ->
        @restaurants_.push new lta.Restaurant name, coordinates, @history_

    ###*
    @param {string} query
    ###
    search: (query) ->
        for restaurant in @restaurants_
            restaurant.search query

    ###*
    @param {google.maps.Map} googleMap
    @expose
    ###
    registerMap: (googleMap) ->
        for restaurant in @restaurants_
            restaurant.registerMapMarker googleMap


window['lta'] = lta
lta['Restaurants'] = lta.Restaurants
