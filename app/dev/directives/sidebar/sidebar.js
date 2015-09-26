var angular = require('angular');
var app = require('../../app.js');
var templateUrl = require('./sidebar.html');

app.directive('sidebar', function() {
  return {
    retrict: 'E',
    templateUrl: templateUrl,
    replace: true,
  }
})
