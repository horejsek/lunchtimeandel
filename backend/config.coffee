
path = require 'path'

express = require 'express'
i18n = require 'i18n'
lessMiddleware = require 'less-middleware'
markdown = require 'node-markdown'
moment = require 'moment'
mongoose = require 'mongoose'

i18n.configure
    locales: ['cs']
    register: global
    updateFiles: true
i18n.setLocale 'cs'

moment.lang 'cs',
    months: ['ledna', 'února', 'března', 'dubna', 'května', 'června', 'července', 'srpna', 'září', 'října', 'listopadu', 'prosince']

mongoose.connect 'mongodb://localhost/lunchtimeandeldb'

module.exports = (app) ->
    app.locals
        __i: __
        __n: __n
        md: markdown.Markdown

    app.configure ->
        app.set 'port', process.env.PORT or 3000
        app.set 'views', __dirname + '/views'
        app.set 'view engine', 'jade'
        app.use express.logger 'dev'
        app.use express.bodyParser()
        app.use i18n.init
        app.use app.router
        app.use lessMiddleware
            src: path.join __dirname, '..', 'public'
            compress: true
        app.use express.static path.join __dirname, '..', 'public'

    app.configure 'development', ->
        app.use express.errorHandler()

    @
