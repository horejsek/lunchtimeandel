(function() {
  var Meal, Restaurant;

  Meal = require('./meal').Meal;

  Restaurant = (function() {

    function Restaurant(db, name, url) {
      this.db_ = db;
      this.name = name;
      this.url = url;
      this.meals = [];
    }

    Restaurant.prototype.addMeal = function(meal) {
      var m, _i, _len, _ref;
      _ref = this.meals;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        m = _ref[_i];
        if (meal.name === m.name) return;
      }
      return this.meals.push(meal);
    };

    Restaurant.prototype.save = function(callback) {
      var db, obj, q;
      q = {
        name: this.name
      };
      db = this.db_;
      obj = this.todb_();
      return this.db_.restaurants.find(q, function(err, res) {
        if (res && res.length) {
          return db.restaurants.update(q, obj, callback);
        } else {
          return db.restaurants.save(obj, callback);
        }
      });
    };

    Restaurant.prototype.todb_ = function() {
      var meal, meals, _i, _len, _ref;
      meals = [];
      _ref = this.meals;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        meal = _ref[_i];
        meals.push(meal.todb_());
      }
      return {
        name: this.name,
        url: this.url,
        meals: meals
      };
    };

    return Restaurant;

  })();

  exports.Restaurant = Restaurant;

}).call(this);
