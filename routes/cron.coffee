
cronJob = require('cron').CronJob

module.exports = (models) ->
    lunchmenuloader = require('../lunchmenuloader')(models)
    job = new cronJob '0 0,30 * * * *', lunchmenuloader, null, true, 'Europe/Prague'

    @
