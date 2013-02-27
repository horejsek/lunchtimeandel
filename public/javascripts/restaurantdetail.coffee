
goog.provide 'lta.restaurantDetail'

goog.require 'goog.dom'


lta.restaurantDetail = (elm) ->
    restaurant = goog.dom.getAncestorByClass elm, 'restaurant'
    restaurantDetail = goog.dom.getElementByClass 'restaurant-detail', restaurant
    goog.dom.classes.toggle restaurantDetail, 'hide'
    # Prevent default.
    return false
