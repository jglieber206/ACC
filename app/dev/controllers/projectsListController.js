var angular = require('angular');
var app = require('../app.js');

var projectsListController = app.controller('ProjectsListController', ['$scope', '$http', '$rootScope', function ($scope, $http, $rootScope) {

  $scope.projectList = [];
  $scope.project = [];
  $scope.project.editing = false;

  $scope.getProjects = function() {
    $http({
      method: 'GET',
      url: '/projects'
    }).success(function(response) {
      $scope.projectList = response;
    })
    .error(function() { window.console && console.log("error") });
  }

  $scope.openProject = function(id) {
    console.log(id)
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
    .error(function() { window.console && console.log("error") });
  }

  $scope.addProject = function(project) {
    $http({
      method: 'POST',
      url: '/projects',
      data: {
        name: project.name
      }
    }).success(function(response) {
      $scope.projectList.push(response);
    })
    .error(function() { window.console && console.log("error") });
  }

  $scope.deleteProject = function(project) {
    $http({
      method: 'DELETE',
      url: '/projects/' + project.id
    }).success(function() {
      $scope.projectList.splice($scope.projectList.indexOf(project), 1)
    })
    .error(function() { window.console && console.log("error") });
  }

}]);

module.exports = projectsListController;
