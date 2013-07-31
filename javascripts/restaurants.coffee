
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
    @type {google.maps.Map}
    @private
    ###
    googleMap_: null

    ###*
    @type {boolean}
    @private
    ###
    showedOnlySelectedMeals_: false

    ###*
    @type {goog.History}
    @public
    ###
    history: null

    ###*
    @constructor
    ###
    constructor: (mapOptions) ->
        @container = goog.dom.getElement 'restaurants'
        @createGoogleMap_ mapOptions
        @constructHistory_()
        @initBtnSelection_()

    ###*
    @private
    ###
    createGoogleMap_: (mapOptions) ->
        # Mobile is without map. Better for time execution and data needed to be downloaded.
        if goog.userAgent.MOBILE
            return
        elm = goog.dom.getElement 'restaurants_map'
        @googleMap_ = new google.maps.Map elm, mapOptions

    ###*
    @private
    ###
    constructHistory_: () ->
        that = @
        @history = new goog.History()
        @history.setEnabled true
        goog.events.listen @history, goog.history.EventType.NAVIGATE, (e) -> that.historyNavigate_ e

    ###*
    @private
    ###
    historyNavigate_: (e) ->
        for restaurant in @restaurants_
            if e.token is restaurant.getId() then restaurant.mark() else restaurant.unmark()

    ###*
    @private
    ###
    initBtnSelection_: () ->
        that = @
        showSelectionBtn = goog.dom.getElement 'show-selection'
        goog.events.listen showSelectionBtn, goog.events.EventType.CLICK, (e) ->
            that.showedOnlySelectedMeals_ = !that.showedOnlySelectedMeals_
            for restaurant in that.restaurants_
                restaurant.showAllOrSelectedMeals that.showedOnlySelectedMeals_

    showOrHideBtnSelection: () ->
        highlightedMeals = goog.dom.getElementsByClass 'meal-highlight', @container
        show = if highlightedMeals.length then true else false

        search = goog.dom.getElement 'search'
        goog.dom.classes.enable search, 'hide-btn-selection', !show

    ###*
    @expose
    ###
    load: () ->
        that = @
        goog.net.XhrIo.send '/api/listall', (e) ->
            that.container.innerHTML = ''

            res = e.target.getResponseJson()
            for restaurantData in res
                restaurant = new lta.Restaurant that, restaurantData
                restaurant.appendToDocument()
                restaurant.registerMapMarker that.googleMap_ if that.googleMap_
                that.restaurants_.push restaurant

            for restaurant in that.restaurants_
                if that.history.getToken() is restaurant.getId()
                    restaurant.scrollTo()
                    restaurant.mark()
                    break

    ###*
    @param {string} query
    ###
    search: (query) ->
        @showedOnlySelectedMeals_ = false
        for restaurant in @restaurants_
            restaurant.search query


window['lta'] = lta
lta['Restaurants'] = lta.Restaurants
