
db = require('../db').connection
Restaurants = require('../models').Restaurants

loader = require('../utils/lunchmenuloader').load


exports.home = (req, res) ->
    restaurants = new Restaurants(db).get (err, restaurants) ->
        res.render 'home',
            title: 'LunchtimeAnděl'
            restaurants: restaurants

exports.reloaddata = (req, res) ->
    res.send 'Reloading...'
    loader()

