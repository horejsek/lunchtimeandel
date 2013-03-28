
goog.provide 'lta.Search'

goog.require 'goog.dom'
goog.require 'goog.dom.query'
goog.require 'goog.events'
goog.require 'goog.events.KeyCodes'
goog.require 'lta.Restaurants'


class lta.Search
    ###*
    @type {Object}
    @private
    ###
    searchinput_: null

    ###*
    @type {Object}
    @private
    ###
    keywordmap_: {
        'a': ['á', 'ä'],
        'c': ['č'],
        'd': ['ď'],
        'e': ['é', 'ě', 'ë'],
        'i': ['í', 'ï'],
        'n': ['ň'],
        'o': ['ó', 'ö'],
        'r': ['ř'],
        's': ['š'],
        't': ['ť'],
        'u': ['ú', 'ů', 'ü'],
        'y': ['ý']
        'z': ['ž'],
    }

    ###*
    @param {string} searchboxId
    @param {lta.Restaurants} restaurants
    @constructor
    ###
    constructor: (searchboxId, restaurants) ->
        that = @
        @restaurants_ = restaurants

        searchbox = goog.dom.getElement searchboxId
        @searchinput_ = goog.dom.getElementsByTagNameAndClass('input', null, searchbox)[0]
        searchbutton = goog.dom.getElementsByTagNameAndClass('button', null, searchbox)[0]

        @searchinput_.focus()
        goog.events.listen @searchinput_, goog.events.EventType.INPUT, (e) ->
            that.search()
        goog.events.listen @searchinput_, goog.events.EventType.KEYUP, (e) ->
            that.clear() if e.keyCode is goog.events.KeyCodes.ESC
        goog.events.listen searchbutton, goog.events.EventType.CLICK, (e) ->
            that.clear()

    clear: () ->
        @searchinput_.value = ''
        @searchinput_.focus()
        # Remove highlight, show restaurant, ...
        @search()

    search: () ->
        pattern = new RegExp @getKeywordForRegexp_(), 'gi'
        @restaurants_.search pattern

    ###*
    @private
    ###
    getKeywordForRegexp_: () ->
        keyword = ''
        for letter in @searchinput_.value
            letters = @keywordmap_[letter] || []
            letters = letters.slice(0)
            letters.push(letter)
            keyword += '[' + (letters).join('') + ']'
        keyword
