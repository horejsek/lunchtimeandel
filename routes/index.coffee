
module.exports = (app) ->
    require './cron'
    require('./routes')(app)
    require('./api')(app)
