
cronJob = require('cron').CronJob

lunchmenuloader = require '../lunchmenuloader'


new cronJob '0 0,30 * * * *', lunchmenuloader, null, true, 'Europe/Prague'
new cronJob '0 15,45 11,12 * * *', lunchmenuloader, null, true, 'Europe/Prague'
