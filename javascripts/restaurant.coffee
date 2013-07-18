
goog.provide 'lta.Restaurant'

goog.require 'goog.dom'
goog.require 'goog.events'
goog.require 'soy'
goog.require 'lta.templates'
goog.require 'lta.smoothlyScrollTo'


class lta.Restaurant
    ###*
    @type {lta.Restaurant}
    @private
    ###
    restaurants_: null

    ###*
    @type {Object}
    @private
    ###
    data_: null

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
    @param {lta.Restaurants} restaurants
    @param {Object} data
    @constructor
    ###
    constructor: (restaurants, data) ->
        @restaurants_ = restaurants
        @data_ = data

    ###*
    @public
    ###
    getId: () ->
        @data_['id']

    ###*
    @private
    ###
    getCountOfMeals_: () ->
        @data_['meals'].length

    ###*
    @public
    ###
    appendToDocument: () ->
        meals = []
        for meal in @data_['meals']
            meals.push
                name: meal['name']
                priceStr: meal['priceStr']
                isExpensive: meal['isExpensive']
                isMainCourse: meal['isMainCourse']
                image: meal['image']
        @contentElm_ = soy.renderAsElement lta.templates.restaurant,
            id: @data_['id']
            name: @data_['name']
            urls:
                homepage: @data_['urls']['homepage']
                lunchmenu: @data_['urls']['lunchmenu']
            phoneNumber: @data_['phoneNumber']
            address:
                street: @data_['address']['street']
                zip: @data_['address']['zip']
                city: @data_['address']['city']
            lastUpdateStr: @data_['lastUpdateStr']
            meals: meals
        @initDetailListener_()
        @initMealHighliter_()

        container = goog.dom.getElement 'restaurants'
        goog.dom.appendChild container, @contentElm_

    ###*
    @private
    ###
    initDetailListener_: () ->
        that = @
        link = goog.dom.getElementByClass 'restaurant-detail-link', @contentElm_
        goog.events.listen link, goog.events.EventType.CLICK, (e) ->
            e.preventDefault()
            that.showHideDetail()

    ###*
    @public
    ###
    showHideDetail: () ->
        restaurantDetail = goog.dom.getElementByClass 'restaurant-detail', @contentElm_
        goog.dom.classes.toggle restaurantDetail, 'hide'

    ###*
    @private
    ###
    initMealHighliter_: () ->
        that = @
        goog.events.listen @contentElm_, goog.events.EventType.CLICK, (e) ->
            tr = goog.dom.getAncestorByTagNameAndClass e.target, 'tr'
            return if not tr
            goog.dom.classes.toggle tr, 'meal-highlight'
            that.restaurants_.showOrHideBtnSelection()

    ###*
    @public
    ###
    showAllOrSelectedMeals: (showOnlySelectedMeals) ->
        that = @
        @showOrHideMeals_ (meal) ->
            return true if !showOnlySelectedMeals
            tr = goog.dom.getAncestorByTagNameAndClass meal, 'tr'
            goog.dom.classes.has tr, 'meal-highlight'

    ###*
    @param {string} query
    @public
    ###
    search: (query) ->
        that = @
        pattern = new RegExp query, 'gi'
        @removeHighlight_()
        @showOrHideMeals_ (meal) ->
            showed = not query or meal.innerHTML.replace('&nbsp;', ' ').search(pattern) > -1
            that.highlight_(meal, query) if showed and query
            return showed

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
        content = meal.innerHTML.replace('&nbsp;', ' ')
        pattern = new RegExp '(.*)(' + query + ')(.*)', 'gi'
        replaceWith = '$1<span class="highlight label label-warning">$2</span>$3'
        meal.innerHTML = content.replace pattern, replaceWith

    ###*
    @private
    ###
    showOrHideMeals_: (callbackIfShowMeal) ->
        countOfShowedMeals = 0
        for meal in @getMealsElms_()
            showed = callbackIfShowMeal meal
            countOfShowedMeals++ if showed
            tr = goog.dom.getAncestorByTagNameAndClass meal, 'tr'
            goog.dom.classes.enable tr, 'hide', !showed
        if countOfShowedMeals
            @show()
        else
            @hide()

    ###*
    @private
    ###
    getMealsElms_: () ->
        goog.dom.getElementsByClass 'meal', @contentElm_

    ###*
    @public
    ###
    show: () ->
        @showHide_ true

    ###*
    @public
    ###
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
            'map': googleMap
            'title': @data_['name']
            'position': new google.maps.LatLng @data_['address']['map']['lat'], @data_['address']['map']['lng']
            'icon': @getDefaultMarkerIconUrl_()
        google.maps.event.addListener @mapMarker_, 'click', () ->
            that.scrollTo()
            that.mark()
            that.restaurants_.history.setToken that.getId()

    ###*
    @public
    ###
    scrollTo: () ->
        lta.smoothlyScrollTo @contentElm_.offsetTop

    ###*
    @public
    ###
    mark: () ->
        goog.dom.classes.add @contentElm_, 'restaurant-highlight'
        @mapMarker_.setIcon @getMarkerIconUrl_ 'blue'

    ###*
    @public
    ###
    unmark: () ->
        goog.dom.classes.remove @contentElm_, 'restaurant-highlight'
        @mapMarker_.setIcon @getDefaultMarkerIconUrl_()

    ###*
    @private
    ###
    getDefaultMarkerIconUrl_: () ->
        if @getCountOfMeals_()
            @getMarkerIconUrl_ 'red'
        else
            @getMarkerIconUrl_ 'gray'

    ###*
    @param {string} name
    @private
    ###
    getMarkerIconUrl_: (name) ->
        'http://labs.google.com/ridefinder/images/mm_20_' + name + '.png'
