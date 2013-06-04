
express = require 'express'
http = require 'http'

app = express()

require('./config')(app)
models = require('./models')(app.mongoose)
require('./routes')(app, models)

http.createServer(app).listen app.get('port'), ->
    console.log 'Express server listening on port ' + app.get('port')
