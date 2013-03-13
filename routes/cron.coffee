
cronJob = require('cron').CronJob

module.exports = (models) ->
    lunchmenuloader = require('../lunchmenuloader')(models)
    # Run at midnight for reset. For someone who is looking very soon in morning...
    job = new cronJob '0 0,30 0,8-12 * * *', lunchmenuloader, null, true, 'Europe/Prague'

    @
