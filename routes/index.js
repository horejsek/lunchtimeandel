(function() {
  var Restaurants, db, loader;

  db = require('../db').connection;

  Restaurants = require('../models').Restaurants;

  loader = require('../utils/lunchmenuloader').load;

  exports.home = function(req, res) {
    var restaurants;
    return restaurants = new Restaurants(db).get(function(err, restaurants) {
      console.log(restaurants);
      return res.render('home', {
        title: 'LunchtimeAnděl',
        restaurants: restaurants
      });
    });
  };

  exports.load = function(req, res) {
    loader();
    return res.send('...');
  };

}).call(this);
