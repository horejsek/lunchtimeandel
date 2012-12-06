(function() {
  var Meal, Restaurant, Restaurants;

  Meal = require('./meal').Meal;

  Restaurant = require('./restaurant').Restaurant;

  Restaurants = (function() {

    function Restaurants(db) {
      this.db_ = db;
    }

    Restaurants.prototype.get = function(callback) {
      var db;
      db = this.db_;
      return this.db_.restaurants.find(function(err, restaurantsData) {
        var meal, restaurant, restaurantData, restaurants, _i, _j, _len, _len2, _ref;
        restaurants = [];
        for (_i = 0, _len = restaurantsData.length; _i < _len; _i++) {
          restaurantData = restaurantsData[_i];
          restaurant = new Restaurant(db, restaurantData.name, restaurantData.url);
          _ref = restaurantData.meals;
          for (_j = 0, _len2 = _ref.length; _j < _len2; _j++) {
            meal = _ref[_j];
            restaurant.addMeal(new Meal(meal.name, meal.price));
          }
          restaurants.push(restaurant);
        }
        return callback(err, restaurants);
      });
    };

    Restaurants.prototype.clear = function() {
      return this.db_.restaurants.remove();
    };

    return Restaurants;

  })();

  exports.Restaurants = Restaurants;

}).call(this);
