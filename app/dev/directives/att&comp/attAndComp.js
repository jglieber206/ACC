var angular = require('angular');
var app = require('../../app.js');
var templateUrl = require('./att-and-comp.html');

app.directive('attAndComp', function() {
  return {
    retrict: 'E',
    templateUrl: templateUrl,
    replace: true,
  }
})
