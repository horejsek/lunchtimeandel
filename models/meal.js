(function() {
  var Meal;

  Meal = (function() {

    function Meal(name, price) {
      this.name = name;
      this.price = price;
    }

    Meal.prototype.todb_ = function() {
      return {
        name: this.name,
        price: this.price
      };
    };

    return Meal;

  })();

  exports.Meal = Meal;

}).call(this);
