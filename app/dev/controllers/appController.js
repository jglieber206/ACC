var angular = require('angular');
var app = require('../app.js');

var appController = app.controller('appController', ['$http', '$rootScope', function ($http, $rootScope) {

  $rootScope.attributesList = [];
  $rootScope.componentsList = [];
  $rootScope.projectCapabilities = [];
  $rootScope.projectMaps = [];

  $rootScope.getAttributes = function(id) {
    $http({
      method: 'GET',
      url: '/projects/' + id + '/attributes'
    }).success(function(response) { $rootScope.attributesList = response })
    .error(function() { window.console && console.log("error") });
  }

  $rootScope.getComponents = function(id) {
    $http({
      method: 'GET',
      url: '/projects/' + id + '/components'
    }).success(function(response) { $rootScope.componentsList = response })
    .error(function() { window.console && console.log("error") });
  }

  $rootScope.getCurrentComp = function(comp_id) {
    compIndex = getIndexById(comp_id, $rootScope.componentsList)
    $rootScope.currentComponent = $rootScope.componentsList[compIndex]
  }

  $rootScope.getProjectCapabilities = function(id) {
    $http({
      method: 'GET',
      url: '/projects/' + id + '/capabilities'
    }).success(function(response) { $rootScope.projectCapabilities = response })
    .error(function() { window.console && console.log("error returning capabilities") });
  }

  $rootScope.getMap = function(id) {
    $http({
      method: 'GET',
      url: '/projects/' + id + '/capability_maps'
    }).success(function(response) { $rootScope.projectMaps = response });
  }

}])
