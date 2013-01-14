
express = require 'express'
i18n = require 'i18n'
path = require 'path'
md = require('node-markdown').Markdown;

moment = require 'moment'
moment.months = ['ledna', 'ůnora', 'března', 'dubna', 'května', 'června', 'července', 'srpna', 'září', 'října', 'listopadu', 'prosince']

module.exports = (app) ->
    i18n.configure
        locales: ['en', 'cs']
        register: global
        updateFiles: true

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
        app.use require('stylus').middleware(__dirname + '/public')
        app.use express.static path.join __dirname, 'public'

    app.configure 'development', ->
        app.use express.errorHandler()

    app.mongoose = require 'mongoose'
    app.mongoose.connect 'mongodb://localhost/lunchtimeandeldb̈́'

    @
