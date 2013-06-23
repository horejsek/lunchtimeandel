
express = require 'express'
i18n = require 'i18n'
md = require('node-markdown').Markdown
path = require 'path'
lessMiddleware = require 'less-middleware'

moment = require 'moment'
moment.lang 'cs',
    months: ['ledna', 'února', 'března', 'dubna', 'května', 'června', 'července', 'srpna', 'září', 'října', 'listopadu', 'prosince']

module.exports = (app) ->
    i18n.configure
        locales: ['cs']
        register: global
        updateFiles: true
    i18n.setLocale 'cs'

    app.locals
        __i: __
        __n: __n
        md: md

    app.configure ->
        app.set 'port', process.env.PORT or 3000
        app.set 'views', __dirname + '/views'
        app.set 'view engine', 'jade'
        app.use express.favicon()
        app.use express.logger 'dev'
        app.use express.bodyParser()
        app.use express.methodOverride()
        app.use express.cookieParser('your secret here')
        app.use express.session()
        app.use i18n.init
        app.use app.router
        app.use lessMiddleware
            src: path.join __dirname, 'public'
            compress: true
        app.use express.static path.join __dirname, 'public'

    app.configure 'development', ->
        app.use express.errorHandler()

    app.mongoose = require 'mongoose'
    app.mongoose.connect 'mongodb://localhost/lunchtimeandeldb'

    @
