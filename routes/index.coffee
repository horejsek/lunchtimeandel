
module.exports = (app, models) ->
    require('./cron')(models)
    require('./routes')(app, models)
    require('./api')(app, models)
