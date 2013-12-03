
assert = require 'assert'
models = require '../backend/models'

describe 'Restaurant', () ->
    steak = new models.Meal
        name: 'Steak'
        price: 120

    restaurant = new models.Restaurant
        id: 'restaurant'
        name: 'Delicious dream'
        urls:
            homepage: 'http://delicious.dream'
            lunchmenu: 'http://delicious.dream/lunchmenu'
        lastUpdate: '2013-01-01 18:30'
        meals: [steak]
        phoneNumber: '+000 123 456 789'
        address:
            street: 'Street'
            city: 'City'
            zip: '123 45'
            map:
                lat: 123
                lng: 456


    describe '#getPrintalbeLastUpdate()', () ->
        it 'should return date as pretty string', () ->
            assert.equal restaurant.getPrintalbeLastUpdate(), '1. ledna v 18:30'

    describe '#getRandomMeal()', () ->
        it 'should return some random meal (there is only steak)', () ->
            randomMeal = restaurant.getRandomMeal()
            assert.ok randomMeal.equals steak

    describe '#addMeal()', () ->
        it 'should add some meal', () ->
            restaurant.addMeal 'cheap soup', 10
            assert.equal restaurant.meals.length, 2
