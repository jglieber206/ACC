var angular = require('angular');
var app = require('../../app.js');
var templateUrl = require('./attributes-directive.html');

app.directive('attributesDirective', function() {
  return {
    retrict: 'E',
    templateUrl: templateUrl,
    replace: true,
  }
})
