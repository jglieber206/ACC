var angular = require('angular');
var app = require('../app.js');


app.controller('AttributesController', ['$scope', '$http', '$rootScope', function ($scope, $http, $rootScope) {

  $scope.addAttribute = function(id) {
    $http({
      method: 'POST',
      url: '/projects/' + id + '/attributes',
      data: this.newAttribute
    }).success(function() {
      $scope.openProject(id)
     })
    .error(function() { console.log("error") });
  }
  $scope.deleteAttribute = function(databaseid) {
    $http({
      method: 'DELETE',
      url: '/attributes/' + databaseid
    }).success(function() {
      var index = $rootScope.attributesList.map(function(e) { return e.id; }).indexOf(databaseid);
      $rootScope.attributesList.splice(index, 1);
    })
    .error(function() { console.log("error") });
  }

}]);
