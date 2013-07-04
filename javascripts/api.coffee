
goog.provide 'lta.api.load'

goog.require 'goog.dom'
goog.require 'goog.events'
goog.require 'goog.net.XhrIo'


lta.api.load = () ->
    elms = goog.dom.getElementsByClass 'example-result'
    for elm in elms
        ((elm) ->
            url = elm.getAttribute 'url'
            goog.net.XhrIo.send url, (e) ->
                res = e.target.getResponseText()
                elm.innerText = res
        )(elm)



window['lta'] = lta
lta['api'] = lta.api
lta.api['load'] = lta.api.load
