
path = require 'path'
moment = require 'moment'
exec = require('child_process').exec

LunchmenuLoader = require './lunchmenuLoader'


tikajar = path.dirname(require.main.filename) + '/../libs/tika-app-1.3.jar'


class UBilehoLvaLoader extends LunchmenuLoader
    constructor: () ->
        @name = 'U Bílého lva'
        @homepage = 'http://www.ubileholva.com'
        @downloadUrl = 'http://www.ubileholva.com/index.cfm/co-bude-dnes-k-obedu/'
        @phoneNumber = '+420 257 316 731'
        @address =
            street: 'Na Bělidle 310/30'
            city: 'Praha 5'
            zip: 15000
            map:
                lat: 50.071753
                lng: 14.405973

    parse: (restaurant, $) ->
        today = moment().format('DD.MM.YY')
        if $('#sysDennMenu a').text().search(today) == -1
            return
        pdflink = $('#sysDennMenu a').attr('href')
        pdflink = @homepage + pdflink if 'http://' not in pdflink
        @parsePdf restaurant, pdflink

    parsePdf: (restaurant, pdflink) ->
        that = @
        command = 'curl ' + pdflink + ' | java -jar ' + tikajar + ' --text | grep -E "^[0-9]{3,4}[^0-9].*" | cut -d" " -f2-'
        exec command, (error, stdout, stderr) ->
            that.parseMenu restaurant, stdout
            # This function is called async, so there must be extra save.
            # Normally is restaurant save immediately after parsing.
            restaurant.save()

    parseMenu: (restaurant, data) ->
        for line in data.split /\n/
            line = line.split /\ (?=[0-9 ]+,-)/
            if line[0] and line[1]
                name = line[0].replace(/([A-Zm]) ([^ ])/g, '$1$2')
                price = line[1]
                restaurant.addMeal name, price


module.exports = UBilehoLvaLoader
