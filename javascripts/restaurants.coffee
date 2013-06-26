
goog.provide 'lta.Restaurants'

goog.require 'goog.dom'
goog.require 'goog.History'
goog.require 'lta.Restaurant'
goog.require 'lta.ChoiceHelp'


class lta.Restaurants
    ###*
    @type {Array}
    @private
    ###
    restaurants_: []

    ###*
    @type {goog.History}
    @private
    ###
    history_: null

    ###*
    @type {google.maps.Map}
    @private
    ###
    googleMap_: null

    ###*
    @constructor
    ###
    constructor: (googleMap) ->
        @googleMap_ = googleMap
        @constructHistory_()

    ###*
    @private
    ###
    constructHistory_: () ->
        that = @
        @history_ = new goog.History()
        @history_.setEnabled true
        goog.events.listen @history_, goog.history.EventType.NAVIGATE, (e) -> that.historyNavigate_ e

    ###*
    @private
    ###
    historyNavigate_: (e) ->
        for restaurant in @restaurants_
            if e.token is restaurant.getId() then restaurant.mark() else restaurant.unmark()

    ###*
    @expose
    ###
    load: () ->
        that = @
        goog.net.XhrIo.send '/api/listall', (e) ->
            container = goog.dom.getElement 'restaurants'
            container.innerHTML = ''

            res = e.target.getResponseJson()
            for restaurant in res
                restaurant = new lta.Restaurant restaurant, that.history_
                restaurant.appendToDocument()
                restaurant.registerMapMarker that.googleMap_
                that.restaurants_.push restaurant

            for restaurant in that.restaurants_
                if that.history_.getToken() is restaurant.getId()
                    restaurant.scrollTo()
                    restaurant.mark()
                    break

    ###*
    @param {string} query
    ###
    search: (query) ->
        for restaurant in @restaurants_
            restaurant.search query


window['lta'] = lta
lta['Restaurants'] = lta.Restaurants
