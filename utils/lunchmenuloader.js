(function() {
  var HusaLoader, LunchmenuLoader, Meal, Restaurant, Restaurants, TGILoader, cheerio, db, request,
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  cheerio = require('cheerio');

  request = require('request');

  db = require('../db').connection;

  Meal = require('../models').Meal;

  Restaurant = require('../models').Restaurant;

  Restaurants = require('../models').Restaurants;

  LunchmenuLoader = (function() {

    function LunchmenuLoader() {}

    LunchmenuLoader.prototype.load = function(restaurantName, url) {
      var that;
      that = this;
      return request({
        uri: url
      }, function(err, response, body) {
        var $, restaurant;
        $ = cheerio.load(body);
        restaurant = new Restaurant(db, restaurantName, url);
        that.parse(restaurant, $);
        return restaurant.save();
      });
    };

    return LunchmenuLoader;

  })();

  TGILoader = (function(_super) {

    __extends(TGILoader, _super);

    function TGILoader() {
      TGILoader.__super__.constructor.apply(this, arguments);
    }

    TGILoader.prototype.parse = function(restaurant, $) {
      return $('#articles table tr').each(function(i, elem) {
        var name, price;
        name = $(this).find('td').first().text().trim();
        price = $(this).find('td').last().text().trim();
        return restaurant.addMeal(new Meal(name, price));
      });
    };

    return TGILoader;

  })(LunchmenuLoader);

  HusaLoader = (function(_super) {

    __extends(HusaLoader, _super);

    function HusaLoader() {
      HusaLoader.__super__.constructor.apply(this, arguments);
    }

    HusaLoader.prototype.parse = function(restaurant, $) {
      var n;
      n = (new Date()).getDay();
      console.log('......', n);
      return $('article table').each(function(i, elem) {
        if (i + 1 === n) {
          return $(this).find('tr').each(function(i, elem) {
            var name, price;
            name = $(this).find('td').first().text().trim() + ' - ' + $(this).find('td').eq(1).text().trim();
            price = $(this).find('td').last().text().trim();
            return restaurant.addMeal(new Meal(name, price));
          });
        }
      });
    };

    return HusaLoader;

  })(LunchmenuLoader);

  exports.load = function() {
    var r;
    r = new Restaurants(db);
    r.clear();
    (new TGILoader).load('TGI Friday', 'http://www.tgifridays.cz/cs/na-andelu/obedove-menu-andel/');
    return (new HusaLoader).load('Husa', 'http://www.phnaverandach.cz/cz/menu/daily-menu');
  };

}).call(this);
