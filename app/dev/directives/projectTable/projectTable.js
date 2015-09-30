var angular = require('angular');
var app = require('../../app.js');
var templateUrl = require('./project-table.html');

app.directive('projectTableDirective', function() {
  return {
    retrict: 'E',
    templateUrl: templateUrl,
    replace: true,
  }
})
