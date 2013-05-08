
goog.provide 'lta.shake'

goog.require 'goog.dom'
goog.require 'goog.events'
goog.require 'goog.math'


lta.shake = () ->
    classes = [
        'mw-harlem_shake_me wobble'
        'mw-harlem_shake_slow wobble'
        'mw-harlem_shake_me bounceIn'
        'mw-harlem_shake_slow bounceIn'
        'mw-harlem_shake_me pulse'
        'mw-harlem_shake_slow pulse'
        'mw-harlem_shake_me shake'
        'mw-harlem_shake_slow shake'
    ]
    for elm in document.querySelectorAll('h1,h2,tr,#map_canvas,#search')
        if goog.math.randomInt 2
            index = goog.math.randomInt classes.length
            goog.dom.classes.add elm, classes[index]


setTimeout lta.shake, 15*60*1000
