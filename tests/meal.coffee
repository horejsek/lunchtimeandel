
assert = require 'assert'
models = require '../backend/models'

describe 'Meal', () ->
    soup = new models.Meal
        name: 'Some free soup'
        price: 0
    pasta = new models.Meal
        name: 'Penne'
        price: 80
    steak = new models.Meal
        name: 'Steak'
        price: 120


    describe '#getPrintablePrice()', () ->
        it 'should return "-" when price is not defined', () ->
            assert.equal soup.getPrintablePrice(), '-'

        it 'should return price with currency', () ->
            assert.equal steak.getPrintablePrice(), '120 Kč'

    describe '#isExpensive()', () ->
        it 'soup should not be expensive', () ->
            assert.equal soup.isExpensive(), false

        it 'steak should be expensive', () ->
            assert.ok steak.isExpensive()

    describe '#isMainCourse()', () ->
        it 'soup should not be main course', () ->
            assert.equal soup.isMainCourse(), false

        it 'steak should be main course', () ->
            assert.ok steak.isMainCourse()

    describe '#getImage()', () ->
        it 'should return image of penne for penne', () ->
            assert.equal pasta.getImage(), '/images/pasta/penne.jpg'

        it 'should return nothing for steak', () ->
            assert.equal steak.getImage(), ''
