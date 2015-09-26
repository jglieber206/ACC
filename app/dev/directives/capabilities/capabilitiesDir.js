var angular = require('angular');
var app = require('../../app.js');
var templateUrl = require('./capabilities-dir.html');

app.directive('capabilitiesDir', function() {
  return {
    retrict: 'E',
    templateUrl: templateUrl,
    replace: true,
  }
})
