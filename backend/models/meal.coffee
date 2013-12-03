
mongoose = require 'mongoose'


pastaImages = [
    'bavette'
    'bucatini'
    'cannelloni'
    'capellini'
    'casarecce'
    'ditaloni'
    'farfalle'
    'farfalline'
    'fettuccine'
    'fusilli_bucati'
    'fusilli_stretti'
    'fusilli'
    'gomiti_rigati'
    'grattugiata'
    'lasagna'
    'linguine'
    'lumaconi'
    'malfattini'
    'manicotti'
    'midolline'
    'orecchiette'
    'orsetti'
    'pappardelle'
    'penne'
    'penne_lisce'
    'penne_rigate'
    'pipe'
    'reginette'
    'riccioli'
    'rigatoni'
    'sedanini_rigati'
    'sedani_rigati'
    'spaghetti'
    'spaghettini'
    'spirali_agli_spinaci'
    'stelline'
    'tagliatelle'
    'tagliatelline'
    'tagliolini'
    'tortiglioni'
]


Meal = new mongoose.Schema
    name: String
    price: Number

Meal.path('name').set (v) ->
    return v.replace('&nbsp;', ' ')

Meal.path('price').set (v) ->
    return parseInt v

Meal.methods.getPrintablePrice = () ->
    if @price then @price + ' Kč' else '-'

Meal.methods.isExpensive = () ->
    @price > 100

Meal.methods.isMainCourse = () ->
    @price > 50

Meal.methods.getImage = () ->
    for pastaImage in pastaImages
        re = new RegExp pastaImage.replace('_', '.*'), 'i'
        if @name.search(re) > -1
            return '/images/pasta/' + pastaImage + '.jpg'
    return ''


module.exports = Meal
