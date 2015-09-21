var angular = require('angular');
var app = require('../app.js');


app.controller('ComponentsController', ['$scope', '$http', '$rootScope', function ($scope, $http, $rootScope) {

  $scope.addComponent = function(id) {
    $http({
      method: 'POST',
      url: '/projects/' + id + '/components',
      data: this.newComponent
    }).success(function() {
      $scope.openProject(id)
    })
    .error(function() { console.log("error") });
  }
  $scope.deleteComponent = function(databaseid) {
    $http({
      method: 'DELETE',
      url: '/components/' + databaseid
    }).success(function() {
      var index = $rootScope.componentsList.map(function(e) { return e.id; }).indexOf(databaseid);
      $rootScope.componentsList.splice(index, 1);
    })
    .error(function() { console.log("error") });
  }


}]);
