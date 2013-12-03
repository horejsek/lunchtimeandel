
models = require '../models'


module.exports = () ->
    console.log 'Reloading data...'
    models.Restaurant.collection.drop (err) ->
        (new (require './andelLoader')).loadData()
        (new (require './andelkaLoader')).loadData()
        (new (require './blazinecLoader')).loadData()
        (new (require './cyrilspubLoader')).loadData()
        (new (require './elBarrioLoader')).loadData()
        (new (require './formankaLoader')).loadData()
        (new (require './hlubinaLoader')).loadData()
        (new (require './husaAndelLoader')).loadData()
        (new (require './husaNaVerandachLoader')).loadData()
        (new (require './ilNostroLoader')).loadData()
        (new (require './jetSetLoader')).loadData()
        (new (require './kristianLoader')).loadData()
        (new (require './laCambusaLoader')).loadData()
        (new (require './lokalblokLoader')).loadData()
        #(new (require './peronLoader')).loadData()
        (new (require './plachtaLoader')).loadData()
        (new (require './pizzerieMediteraneLoader')).loadData()
        (new (require './sodexoLoader')).loadData()
        (new (require './tgiLoader')).loadData()
        (new (require './tradiceLoader')).loadData()
        (new (require './uBilehoLvaLoader')).loadData()
        (new (require './uZiznivehoJelenaLoader')).loadData()
        (new (require './zlatyKlasLoader')).loadData()
