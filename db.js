(function() {
  var collections, databaseUrl;

  databaseUrl = 'lunchtimeandeldb̈́';

  collections = ['restaurants'];

  exports.connection = require('mongojs').connect(databaseUrl, collections);

}).call(this);
