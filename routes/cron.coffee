
cronJob = require('cron').CronJob

module.exports = (models) ->
    lunchmenuloader = require('../utils/lunchmenuloader')(models)
    job = new cronJob '0 0 8-12 * * *', lunchmenuloader, null, true, 'Europe/Prague'

    @
