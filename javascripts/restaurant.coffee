
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
    @type {boolean}
    @private
    ###
    marked_: false

    ###*
    @param {lta.Restaurants} restaurants
    @param {Object} data
    @constructor
    ###
    constructor: (restaurants, data) ->
        @restaurants_ = restaurants
        @data_ = data
        @data_['isFavorite'] = window.localStorage.getItem(@data_['id'] + '_isFavorite') is 'true'
        @data_['isHidden'] = window.localStorage.getItem(@data_['id'] + '_isHidden') is 'true'
        @marked_ = false

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
            isFavorite: @data_['isFavorite']
            isHidden: @data_['isHidden']
            meals: meals
        @initDetailListener_()
        @initMealHighliter_()

        goog.dom.appendChild @getContainer_(), @contentElm_

    ###*
    @private
    ###
    getContainer_: () ->
        if @data_['isHidden']
            containerId = 'hidden-restaurants'
        else if @data_['isFavorite']
            containerId = 'favorite-restaurants'
        else
            containerId = 'restaurants'
        goog.dom.getElement containerId

    ###*
    @private
    ###
    initDetailListener_: () ->
        that = @

        detailLink = goog.dom.getElementByClass 'restaurant-detail-link', @contentElm_
        goog.events.listen detailLink, goog.events.EventType.CLICK, (e) ->
            e.preventDefault()
            that.toggleDetail()

        hideButton = goog.dom.getElementByClass 'restaurant-hide', @contentElm_
        goog.events.listen hideButton, goog.events.EventType.CLICK, (e) ->
            that.toggleHide()

        favoriteButton = goog.dom.getElementByClass 'restaurant-favorite', @contentElm_
        goog.events.listen favoriteButton, goog.events.EventType.CLICK, (e) ->
            that.toggleFavorite()

    ###*
    @public
    ###
    toggleDetail: () ->
        restaurantDetail = goog.dom.getElementByClass 'restaurant-detail', @contentElm_
        goog.dom.classes.toggle restaurantDetail, 'hide'

    ###*
    @public
    ###
    toggleHide: () ->
        @data_['isHidden'] = !@data_['isHidden']
        window.localStorage.setItem(@data_['id'] + '_isHidden', @data_['isHidden'])

        restaurantContent = goog.dom.getElementByClass 'restaurant-content', @contentElm_
        goog.dom.classes.enable restaurantContent, 'hide', @data_['isHidden']

        hideButton = goog.dom.getElementByClass 'restaurant-hide', @contentElm_
        goog.dom.classes.enable hideButton, 'icon-plus-sign', @data_['isHidden']
        goog.dom.classes.enable hideButton, 'icon-remove-sign', !@data_['isHidden']

        @reappendToContainer_()

    ###*
    @public
    ###
    toggleFavorite: () ->
        @data_['isFavorite'] = !@data_['isFavorite']
        window.localStorage.setItem(@data_['id'] + '_isFavorite', @data_['isFavorite'])
        @setMapMarkColor_()

        favoriteButton = goog.dom.getElementByClass 'restaurant-favorite', @contentElm_
        goog.dom.classes.enable favoriteButton, 'icon-star', @data_['isFavorite']
        goog.dom.classes.enable favoriteButton, 'icon-star-empty', !@data_['isFavorite']

        @reappendToContainer_()

    ###*
    @private
    ###
    reappendToContainer_: () ->
        goog.dom.removeNode @contentElm_
        goog.dom.insertChildAt @getContainer_(), @contentElm_, 0
        @scrollTo()

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
            showed = not query or meal.innerHTML.replace('&nbsp;', ' ').search(pattern) > -1 or that.data_['name'].search(pattern) > -1
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
        @marked_ = true
        @setMapMarkColor_()
        goog.dom.classes.add @contentElm_, 'restaurant-highlight'

    ###*
    @public
    ###
    unmark: () ->
        @marked_ = false
        @setMapMarkColor_()
        goog.dom.classes.remove @contentElm_, 'restaurant-highlight'

    ###*
    @private
    ###
    setMapMarkColor_: () ->
        if @marked_
            @mapMarker_.setIcon @getMarkerIconUrl_ 'blue'
        else
            @mapMarker_.setIcon @getDefaultMarkerIconUrl_()

    ###*
    @private
    ###
    getDefaultMarkerIconUrl_: () ->
        if @getCountOfMeals_()
            defaultColor = if @data_['isFavorite'] then 'green' else 'red'
            @getMarkerIconUrl_ defaultColor
        else
            @getMarkerIconUrl_ 'gray'

    ###*
    @param {string} color
    @private
    ###
    getMarkerIconUrl_: (color) ->
        'http://labs.google.com/ridefinder/images/mm_20_' + color + '.png'
