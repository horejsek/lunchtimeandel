
/*
 * GET home page.
 */

var cheerio = require('cheerio');
var request = require('request');


var f = function(restaurantName, url) {
    request({uri: url}, function(err, response, body) {
        var $ = cheerio.load(body);

        restaurant = {
            name: restaurantName,
            url: url,
            items: []
        }

        $('#articles table tr').each(function(i, elem) {
            restaurant.items.push({
                'name': $(this).find('td').first().text().trim(),
                'price': $(this).find('td').last().text().trim()
            })
        });

        console.log(restaurant);
    });
};

f('TGI Friday', 'http://www.tgifridays.cz/cs/na-andelu/obedove-menu-andel/');


exports.home = function(req, res){
    console.log('a');
    res.render('home', {title: 'LunchtimeAnděl', restaurants: [
        {
            name: 'Název',
            url: 'url',
            items: [
                {
                    name: 'oběd',
                    price: 10.2
                },
                {
                    name: 'obídek',
                    price: 50.3
                }
            ]
        }
    ]});
};
