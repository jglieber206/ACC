var angular = require('angular');
var app = require('../../app.js');
var templateUrl = require('./components-directive.html');

app.directive('componentsDirective', function() {
  return {
    retrict: 'E',
    templateUrl: templateUrl,
    replace: true,
  }
})
