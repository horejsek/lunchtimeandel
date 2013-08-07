
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
    restaurants: []

    ###*
    @type {google.maps.Map}
    @private
    ###
    googleMap: null

    ###*
    @type {Element}
    @private
    ###
    container: null

    ###*
    @type {boolean}
    @private
    ###
    showedOnlySelectedMeals: false

    ###*
    @type {goog.History}
    ###
    history: null

    ###*
    @constructor
    ###
    constructor: (mapOptions) ->
        @container = goog.dom.getElement 'restaurants'
        @createGoogleMap mapOptions
        @constructHistory()
        @initBtnSelection()

    ###*
    @private
    ###
    createGoogleMap: (mapOptions) ->
        # Mobile is without map. Better for time execution and data needed to be downloaded.
        if goog.userAgent.MOBILE
            return
        elm = goog.dom.getElement 'restaurants_map'
        @googleMap = new google.maps.Map elm, mapOptions

    ###*
    @private
    ###
    constructHistory: () ->
        that = @
        @history = new goog.History()
        @history.setEnabled true
        goog.events.listen @history, goog.history.EventType.NAVIGATE, (e) -> that.historyNavigate e

    ###*
    @private
    ###
    historyNavigate: (e) ->
        for restaurant in @restaurants
            if e.token is restaurant.getId() then restaurant.mark() else restaurant.unmark()

    ###*
    @private
    ###
    initBtnSelection: () ->
        that = @
        showSelectionBtn = goog.dom.getElement 'show-selection'
        goog.events.listen showSelectionBtn, goog.events.EventType.CLICK, (e) ->
            that.showedOnlySelectedMeals = !that.showedOnlySelectedMeals
            for restaurant in that.restaurants
                restaurant.showAllOrSelectedMeals that.showedOnlySelectedMeals

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
            goog.dom.getElement('common-restaurants').innerHTML = ''

            res = e.target.getResponseJson()
            for restaurantData in res
                restaurant = new lta.Restaurant that, restaurantData
                restaurant.appendToDocument()
                restaurant.registerMapMarker that.googleMap if that.googleMap
                that.restaurants.push restaurant

            for restaurant in that.restaurants
                if that.history.getToken() is restaurant.getId()
                    restaurant.scrollTo()
                    restaurant.mark()
                    break

    ###*
    @param {string} query
    ###
    search: (query) ->
        @showedOnlySelectedMeals = false
        for restaurant in @restaurants
            restaurant.search query


window['lta'] = lta
lta['Restaurants'] = lta.Restaurants
