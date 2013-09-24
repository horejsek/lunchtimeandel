
module.exports = (models) ->
    load = () ->
        console.log 'Reloading data...'
        models.Restaurant.collection.drop (err) ->
            (new (require('./andelLoader')(models))()).loadData()
            (new (require('./andelkaLoader')(models))()).loadData()
            (new (require('./blazinecLoader')(models))()).loadData()
            (new (require('./cyrilspubLoader')(models))()).loadData()
            (new (require('./elBarrioLoader')(models))()).loadData()
            (new (require('./formankaLoader')(models))()).loadData()
            (new (require('./hlubinaLoader')(models))()).loadData()
            (new (require('./husaAndelLoader')(models))()).loadData()
            (new (require('./husaNaVerandachLoader')(models))()).loadData()
            (new (require('./ilNostroLoader')(models))()).loadData()
            (new (require('./jetSetLoader')(models))()).loadData()
            (new (require('./kristianLoader')(models))()).loadData()
            (new (require('./laCambusaLoader')(models))()).loadData()
            (new (require('./lokalblokLoader')(models))()).loadData()
            #(new (require('./peronLoader')(models))()).loadData()
            (new (require('./plachtaLoader')(models))()).loadData()
            (new (require('./pizzerieMediteraneLoader')(models))()).loadData()
            (new (require('./sodexoLoader')(models))()).loadData()
            (new (require('./tgiLoader')(models))()).loadData()
            (new (require('./tradiceLoader')(models))()).loadData()
            (new (require('./uBilehoLvaLoader')(models))()).loadData()
            (new (require('./uZiznivehoJelenaLoader')(models))()).loadData()
            (new (require('./zlatyKlasLoader')(models))()).loadData()
