var angular = require('angular');
var app = require('../app.js');

var projectsListController = app.controller('ProjectsListController', ['$scope', '$http', '$rootScope', function ($scope, $http, $rootScope) {

  $scope.projectList = [];
  $scope.project = [];

  $scope.getProjects = function() {
    $http({
      method: 'GET',
      url: '/projects'
    }).success(function(response) {
      $scope.projectList = response;
    })
    .error(function() { console.log("error") });
  }

  $scope.openProject = function(id) {
    $http({
      method: 'GET',
      url: '/projects/' + id
    }).success(function(response) {
      $scope.project = response;
      $rootScope.getAttributes(id);
      $rootScope.getComponents(id);
      $rootScope.getProjectCapabilities(id);
      $rootScope.getMap(id);
    })
    .error(function() { console.log("error") });
  }
  $scope.addProject = function() {
    $http({
      method: 'POST',
      url: '/projects',
      data: this.newProject
    }).success(function() {
      $scope.getProjects();
    })
    .error(function() { console.log("error") });
  }
  $scope.deleteProject = function(id) {
    $http({
      method: 'DELETE',
      url: '/projects/' + id
    }).success(function() {
      $scope.getProjects();
    })
    .error(function() { console.log("error") });
  }

}]);

module.exports = projectsListController;
