
module.exports = (models) ->
    load = () ->
        console.log 'Reloading data...'
        models.Restaurant.collection.drop (err) ->
            (new (require('./tgiLoader')(models))()).loadData()
            (new (require('./husaNaVerandachLoader')(models))()).loadData()
            (new (require('./husaAndelLoader')(models))()).loadData()
            (new (require('./ilNostroLoader')(models))()).loadData()
            (new (require('./uBilehoLvaLoader')(models))()).loadData()
            (new (require('./andelkaLoader')(models))()).loadData()
            (new (require('./zlatyKlasLoader')(models))()).loadData()
            (new (require('./tradiceLoader')(models))()).loadData()
            (new (require('./hlubinaLoader')(models))()).loadData()
            (new (require('./laCambusaLoader')(models))()).loadData()
            (new (require('./elBarrioLoader')(models))()).loadData()
            (new (require('./formankaLoader')(models))()).loadData()
            (new (require('./jetSetLoader')(models))()).loadData()
            (new (require('./cyrilspubLoader')(models))()).loadData()
