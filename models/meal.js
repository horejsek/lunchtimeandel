(function() {
  var Meal;

  Meal = (function() {

    function Meal(name, price) {
      this.name = name;
      price = parseInt(price);
      if (price) {
        this.price = price;
        this.printablePrice = this.price + ' Kč';
      } else {
        this.price = this.printablePrice = '-';
      }
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
