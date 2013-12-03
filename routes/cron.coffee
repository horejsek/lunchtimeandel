
cronJob = require('cron').CronJob

lunchmenuloader = require '../lunchmenuloader'


new cronJob '0 0,30 * * * *', lunchmenuloader, null, true, 'Europe/Prague'
new cronJob '11,12 15,45 * * * *', lunchmenuloader, null, true, 'Europe/Prague'
