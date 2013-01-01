
Meal = require('./meal').Meal

class Restaurant
    constructor: (db, name, url, lastUpdate) ->
        @db_ = db
        @name = name
        @url = url
        @lastUpdate = lastUpdate
        @meals = []

    getPrintalbeLastUpdate: () ->
        day = @lastUpdate.getDate() + ". " + (@lastUpdate.getMonth() + 1) + "."
        hour = @lastUpdate.toTimeString().substring(0, 5)
        day + " v " + hour

    addMeal: (meal) ->
        for m in @meals
            if meal.name is m.name
                return
        @meals.push meal

    save: (callback) ->
        q = name: @name
        db = @db_
        obj = @todb_()
        @db_.restaurants.find q, (err, res) ->
            if res && res.length
                db.restaurants.update q, obj, callback
            else
                db.restaurants.save obj, callback

    todb_: () ->
        meals = []
        for meal in @meals
            meals.push meal.todb_()
        name: @name
        url: @url
        meals: meals
        lastUpdate: new Date()

exports.Restaurant = Restaurant
