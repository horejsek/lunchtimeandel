
express = require 'express'
http = require 'http'

app = express()

require('./config')(app)
models = require('./models')(app.mongoose)
require('./routes/routes')(app, models)
require('./routes/cron')(models)

http.createServer(app).listen app.get('port'), ->
    console.log 'Express server listening on port ' + app.get('port')
