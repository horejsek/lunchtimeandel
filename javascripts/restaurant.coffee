
goog.provide 'lta.Restaurant'

goog.require 'goog.dom'
goog.require 'goog.events'
goog.require 'soy'
goog.require 'lta.templates'


class lta.Restaurant
    ###*
    @type {Object}
    @private
    ###
    data_: null

    ###*
    @type {goog.History}
    @private
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
    @param {Object} data
    @param {goog.History} history
    @constructor
    ###
    constructor: (data, history) ->
        @data_ = data
        @history_ = history

    getId: () ->
        @data_['id']

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
            that.showHideDetail e

    showHideDetail: (e) ->
        restaurantDetail = goog.dom.getElementByClass 'restaurant-detail', @contentElm_
        goog.dom.classes.toggle restaurantDetail, 'hide'
        e.preventDefault()

    ###*
    @private
    ###
    initMealHighliter_: () ->
        goog.events.listen @contentElm_, goog.events.EventType.CLICK, (e) ->
            tr = goog.dom.getAncestorByTagNameAndClass e.target, 'tr'
            return if not tr
            goog.dom.classes.toggle tr, 'meal-highlight'

    ###*
    @private
    ###
    getMealsElms_: () ->
        goog.dom.getElementsByClass 'meal', @contentElm_

    ###*
    @private
    ###
    getCountOfMeals_: () ->
        @data_['meals'].length

    ###*
    @param {string} query
    ###
    search: (query) ->
        pattern = new RegExp query, 'gi'
        @removeHighlight_()
        countOfShowedMeals = 0
        for meal in @getMealsElms_()
            showed = not query or meal.innerHTML.search(pattern) > -1
            countOfShowedMeals++ if showed
            @highlight_(meal, query) if showed and query
            goog.dom.classes.enable meal.parentNode.parentNode, 'hide', !showed
        if countOfShowedMeals or not query
            @show()
        else
            @hide()

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
            'map': googleMap
            'title': @data_['name']
            'position': new google.maps.LatLng @data_['address']['map']['lat'], @data_['address']['map']['lng']
            'icon': @getDefaultMarkerIconUrl_()
        google.maps.event.addListener @mapMarker_, 'click', () ->
            that.scrollTo()
            that.mark()
            that.history_.setToken that.getId()

    mark: () ->
        goog.dom.classes.add @contentElm_, 'restaurant-highlight'
        @mapMarker_.setIcon @getMarkerIconUrl_ 'blue'

    unmark: () ->
        goog.dom.classes.remove @contentElm_, 'restaurant-highlight'
        @mapMarker_.setIcon @getDefaultMarkerIconUrl_()

    scrollTo: () ->
        frameTime = 10 # ms
        totalTime = 300 # ms

        position = startPosition = window.scrollY
        maxEndPosition = document.height - window.innerHeight
        endPosition = if @contentElm_.offsetTop > maxEndPosition then maxEndPosition else @contentElm_.offsetTop
        scrollBy = (endPosition - startPosition)*frameTime/totalTime

        shouldAnimate = (position, scrollBy) ->
            (scrollBy > 0 and position < endPosition) or (scrollBy < 0 and position > endPosition)
        animate = () ->
            #  Used scrollTo because ID automatically scroll to element, so
            #+ scollBy would calculate it wrongly.
            if !shouldAnimate(position + scrollBy, scrollBy)
                scrollBy = if scrollBy > 0 then 2 else -2
            position += scrollBy
            window.scrollTo 0, position
            if shouldAnimate(position, scrollBy)
                setTimeout animate, frameTime
        animate() if scrollBy

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
