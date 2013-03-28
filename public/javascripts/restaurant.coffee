
goog.provide 'lta.Restaurant'

goog.require 'goog.dom'
goog.require 'goog.events'


class lta.Restaurant
    ###*
    @type {string}
    @protected
    ###
    name: ''

    ###*
    @type {Object}
    @private
    ###
    coordinates_: null

    ###*
    @type {goog.History}
    ###
    history_: null

    ###*
    @type {Element}
    @private
    ###
    contentElm_: null

    ###*
    @type {google.maps.Marker}
    @private
    ###
    mapMarker_: null

    ###*
    @param {string} name
    @param {Object} coordinates
    @param {goog.History} history
    @constructor
    ###
    constructor: (name, coordinates, history) ->
        @name = name
        @coordinates_ = coordinates
        @history_ = history
        @contentElm_ = goog.dom.getElement name
        @initListeners_()

    ###*
    @private
    ###
    initListeners_: () ->
        @initDetailListener_()

    ###*
    @private
    ###
    initDetailListener_: () ->
        that = @
        link = goog.dom.getElementByClass 'restaurant-detail-link', @contentElm_
        goog.events.listen link, goog.events.EventType.CLICK, (e) ->
            that.showHideDetail e

    showHideDetail: (e) ->
        restaurantDetail = goog.dom.getElementByClass 'restaurant-detail', @contentElm_
        goog.dom.classes.toggle restaurantDetail, 'hide'
        e.preventDefault()

    ###*
    @private
    ###
    getMealsElms_: () ->
        goog.dom.getElementsByClass 'meal', @contentElm_

    ###*
    @param {string} query
    ###
    search: (query) ->
        @removeHighlight_()
        countOfShowedMeals = 0
        for meal in @getMealsElms_()
            showed = not query or meal.innerHTML.search(query) > -1
            countOfShowedMeals++ if showed
            @highlight_(meal, query) if showed and query
            goog.dom.classes.enable meal.parentNode, 'hide', !showed
        if countOfShowedMeals then @show() else @hide()

    ###*
    @private
    ###
    removeHighlight_: () ->
        for elm in goog.dom.getElementsByClass 'highlight', @contentElm_
            text = goog.dom.createTextNode goog.dom.getTextContent elm
            goog.dom.replaceNode text, elm

    ###*
    @private
    ###
    highlight_: (meal, query) ->
        content = meal.innerHTML
        pattern = new RegExp '(.*)(' + query + ')(.*)', 'gi'
        replaceWith = '$1<span class="highlight label label-warning">$2</span>$3'
        meal.innerHTML = content.replace pattern, replaceWith

    show: () ->
        @showHide_ true

    hide: () ->
        @showHide_ false

    ###*
    @param {boolean} show
    @private
    ###
    showHide_: (show) ->
        goog.dom.classes.enable @contentElm_, 'hide', !show
        @mapMarker_.setVisible show if @mapMarker_

    ###*
    @param {google.maps.Map} googleMap
    ###
    registerMapMarker: (googleMap) ->
        that = @
        @mapMarker_ = new google.maps.Marker
            map: googleMap
            title: @name
            position: new google.maps.LatLng @coordinates_.lat, @coordinates_.lon
            icon: 'http://maps.google.com/mapfiles/ms/micons/red-dot.png'
        google.maps.event.addListener @mapMarker_, 'click', () ->
            that.history_.setToken that.name
            that.mark()
        @mark() if that.history_.getToken() is @name

    mark: () ->
        @mapMarker_.setIcon 'http://maps.google.com/mapfiles/ms/micons/blue-dot.png'

    unmark: () ->
        @mapMarker_.setIcon 'http://maps.google.com/mapfiles/ms/micons/red-dot.png'
