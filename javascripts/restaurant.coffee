
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
    restaurants: null

    ###*
    @type {Object}
    @private
    ###
    data: null

    ###*
    @type {Element}
    @private
    ###
    contentElm: null

    ###*
    @type {google.maps.Marker}
    @private
    ###
    mapMarker: null

    ###*
    @type {boolean}
    @private
    ###
    marked: false

    ###*
    @param {lta.Restaurants} restaurants
    @param {Object} data
    @constructor
    ###
    constructor: (@restaurants, @data) ->
        @data['isFavorite'] = window.localStorage.getItem(@data['id'] + '_isFavorite') is 'true'
        @data['isHidden'] = window.localStorage.getItem(@data['id'] + '_isHidden') is 'true'
        @marked = false

    ###*
    @public
    ###
    getId: () ->
        @data['id']

    ###*
    @private
    ###
    getCountOfMeals: () ->
        @data['meals'].length

    ###*
    @public
    ###
    appendToDocument: () ->
        meals = []
        for meal in @data['meals']
            meals.push
                name: meal['name']
                priceStr: meal['priceStr']
                isExpensive: meal['isExpensive']
                isMainCourse: meal['isMainCourse']
                image: meal['image']
        @contentElm = soy.renderAsElement lta.templates.restaurant,
            id: @data['id']
            name: @data['name']
            urls:
                homepage: @data['urls']['homepage']
                lunchmenu: @data['urls']['lunchmenu']
            phoneNumber: @data['phoneNumber']
            address:
                street: @data['address']['street']
                zip: @data['address']['zip']
                city: @data['address']['city']
            lastUpdateStr: @data['lastUpdateStr']
            isFavorite: @data['isFavorite']
            isHidden: @data['isHidden']
            meals: meals
        @initDetailListener()
        @initMealHighliter()

        goog.dom.appendChild @getContainer(), @contentElm

    ###*
    @private
    ###
    getContainer: () ->
        if @data['isHidden']
            containerId = 'hidden-restaurants'
        else if @data['isFavorite']
            containerId = 'favorite-restaurants'
        else
            containerId = 'restaurants'
        goog.dom.getElement containerId

    ###*
    @private
    ###
    initDetailListener: () ->
        that = @

        detailLink = goog.dom.getElementByClass 'restaurant-detail-link', @contentElm
        goog.events.listen detailLink, goog.events.EventType.CLICK, (e) ->
            e.preventDefault()
            that.toggleDetail()

        hideButton = goog.dom.getElementByClass 'restaurant-hide', @contentElm
        goog.events.listen hideButton, goog.events.EventType.CLICK, (e) ->
            that.toggleHide()

        favoriteButton = goog.dom.getElementByClass 'restaurant-favorite', @contentElm
        goog.events.listen favoriteButton, goog.events.EventType.CLICK, (e) ->
            that.toggleFavorite()

    ###*
    @public
    ###
    toggleDetail: () ->
        restaurantDetail = goog.dom.getElementByClass 'restaurant-detail', @contentElm
        goog.dom.classes.toggle restaurantDetail, 'hide'

    ###*
    @public
    ###
    toggleHide: () ->
        @data['isHidden'] = !@data['isHidden']
        window.localStorage.setItem(@data['id'] + '_isHidden', @data['isHidden'])

        restaurantContent = goog.dom.getElementByClass 'restaurant-content', @contentElm
        goog.dom.classes.enable restaurantContent, 'hide', @data['isHidden']

        hideButton = goog.dom.getElementByClass 'restaurant-hide', @contentElm
        goog.dom.classes.enable hideButton, 'icon-plus-sign', @data['isHidden']
        goog.dom.classes.enable hideButton, 'icon-remove-sign', !@data['isHidden']

        @reappendToContainer()

    ###*
    @public
    ###
    toggleFavorite: () ->
        @data['isFavorite'] = !@data['isFavorite']
        window.localStorage.setItem(@data['id'] + '_isFavorite', @data['isFavorite'])
        @setMapMarkColor()

        favoriteButton = goog.dom.getElementByClass 'restaurant-favorite', @contentElm
        goog.dom.classes.enable favoriteButton, 'icon-star', @data['isFavorite']
        goog.dom.classes.enable favoriteButton, 'icon-star-empty', !@data['isFavorite']

        @reappendToContainer()

    ###*
    @private
    ###
    reappendToContainer: () ->
        goog.dom.removeNode @contentElm
        goog.dom.insertChildAt @getContainer(), @contentElm, 0
        @scrollTo()

    ###*
    @private
    ###
    initMealHighliter: () ->
        that = @
        goog.events.listen @contentElm, goog.events.EventType.CLICK, (e) ->
            tr = goog.dom.getAncestorByTagNameAndClass e.target, 'tr'
            return if not tr
            goog.dom.classes.toggle tr, 'meal-highlight'
            that.restaurants.showOrHideBtnSelection()

    ###*
    @public
    ###
    showAllOrSelectedMeals: (showOnlySelectedMeals) ->
        that = @
        @showOrHideMeals (meal) ->
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
        @removeHighlight()
        callback = (meal) ->
            showed = not query or meal.innerHTML.replace('&nbsp;', ' ').search(pattern) > -1 or that.data['name'].search(pattern) > -1
            that.highlight(meal, query) if showed and query
            return showed
        forceShow = not query or @data['name'].search(pattern) > -1
        @showOrHideMeals callback, forceShow

    ###*
    @private
    ###
    removeHighlight: () ->
        for elm in goog.dom.getElementsByClass 'highlight', @contentElm
            text = goog.dom.createTextNode goog.dom.getTextContent elm
            goog.dom.replaceNode text, elm

    ###*
    @private
    ###
    highlight: (meal, query) ->
        content = meal.innerHTML.replace('&nbsp;', ' ')
        pattern = new RegExp '(.*)(' + query + ')(.*)', 'gi'
        replaceWith = '$1<span class="highlight label label-warning">$2</span>$3'
        meal.innerHTML = content.replace pattern, replaceWith

    ###*
    @private
    ###
    showOrHideMeals: (callbackIfShowMeal, forceShow) ->
        countOfShowedMeals = 0
        for meal in @getMealsElms()
            showed = callbackIfShowMeal meal
            countOfShowedMeals++ if showed
            tr = goog.dom.getAncestorByTagNameAndClass meal, 'tr'
            goog.dom.classes.enable tr, 'hide', !showed
        if countOfShowedMeals or forceShow
            @show()
        else
            @hide()

    ###*
    @private
    ###
    getMealsElms: () ->
        goog.dom.getElementsByClass 'meal', @contentElm

    ###*
    @public
    ###
    show: () ->
        @showHide true

    ###*
    @public
    ###
    hide: () ->
        @showHide false

    ###*
    @param {boolean} show
    @private
    ###
    showHide: (show) ->
        goog.dom.classes.enable @contentElm, 'hide', !show
        @mapMarker.setVisible show if @mapMarker

    ###*
    @param {google.maps.Map} googleMap
    ###
    registerMapMarker: (googleMap) ->
        that = @
        @mapMarker = new google.maps.Marker
            'map': googleMap
            'title': @data['name']
            'position': new google.maps.LatLng @data['address']['map']['lat'], @data['address']['map']['lng']
            'icon': @getDefaultMarkerIconUrl()
        google.maps.event.addListener @mapMarker, 'click', () ->
            that.scrollTo()
            that.mark()
            that.restaurants.history.setToken that.getId()

    ###*
    @public
    ###
    scrollTo: () ->
        lta.smoothlyScrollTo @contentElm.offsetTop

    ###*
    @public
    ###
    mark: () ->
        @marked = true
        @setMapMarkColor()
        goog.dom.classes.add @contentElm, 'restaurant-highlight'

    ###*
    @public
    ###
    unmark: () ->
        @marked = false
        @setMapMarkColor()
        goog.dom.classes.remove @contentElm, 'restaurant-highlight'

    ###*
    @private
    ###
    setMapMarkColor: () ->
        if @marked
            @mapMarker.setIcon @getMarkerIconUrl 'blue'
        else
            @mapMarker.setIcon @getDefaultMarkerIconUrl()

    ###*
    @private
    ###
    getDefaultMarkerIconUrl: () ->
        if @getCountOfMeals()
            defaultColor = if @data['isFavorite'] then 'green' else 'red'
            @getMarkerIconUrl defaultColor
        else
            @getMarkerIconUrl 'gray'

    ###*
    @param {string} color
    @private
    ###
    getMarkerIconUrl: (color) ->
        'http://labs.google.com/ridefinder/images/mm_20_' + color + '.png'
