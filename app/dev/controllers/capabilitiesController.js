var angular = require('angular');
var app = require('../app.js');
var moment = require('moment');

app.controller('CapabilitiesController', ['$scope', '$http', '$rootScope', function ($scope, $http, $rootScope) {
    $scope.currentAttribute = null;
    $scope.currentComponent = null;
    $scope.capsInCell = [];
    $scope.a = [];
    $scope.previewResponse;

    $scope.addCapability = function(newCapability, proj_id) {
      $http({
        method: 'POST',
        url: '/attributes/'+$scope.currentAttribute.id+'/components/'+$scope.currentComponent.id,
        data: {
          integration: newCapability.integration,
          name: newCapability.capabilityName,
          project_id: proj_id,
          code: newCapability.capabilityCode,
          url: newCapability.capabilityUrl
        }
      }).success(function(response) {
        $scope.capsInCell.push(response)
      }).error(function() {
        window.console && console.log("error adding capability")
      });
    }

    $scope.output = function output(inp) {
      if (!document.getElementsByTagName('pre')[0]) {
        document.getElementById("jsonPreview").appendChild(document.createElement('pre')).innerHTML = inp;
      } else {
        document.getElementsByTagName('pre')[0].innerHTML = inp;
      }
    }

    $scope.preview = function(newCapability) {
      $http({
        method: 'POST',
        url: '/preview',
        data: {
          integration: newCapability.integration,
          url: newCapability.capabilityUrl
        }
      }).success(function(response) {
        $scope.previewResponse = JSON.stringify(response, null, 2)
        $scope.output($scope.previewResponse)
      }).error(function() {
        window.console && console.log("error getting preview")
      });
    }

    $scope.clearPreview = function() {
      document.getElementsByTagName('pre')[0].innerHTML = "";
    }

    $scope.updateCapability = function(capability) {
      $http({
        method: 'POST',
        url: '/capabilities/update/' + capability.id,
        data: {
          integration: capability.integration,
          name: capability.name,
          code: capability.code,
          url: capability.url
        }
      }).success(function(response) {
        $scope.capsInCell.splice($scope.capsInCell.indexOf(capability), 1, response);
      }).error(function() {
        window.console && console.log("error adding capability")
      });
    }

    $scope.deleteCapability = function(capability) {
      $http({
        method: 'DELETE',
        url: '/capabilities/' + capability.id
      })
      .success(function(capability) {
        $scope.capsInCell.splice($scope.capsInCell.indexOf(capability), 1)
       }).error(function() {
         window.console && console.log("error deleting capability")
       });
    }

    $scope.getCurrentAttr = function(attr_id) {
      attrIndex = getIndexById(attr_id, $scope.attributesList);
      $scope.currentAttribute = $scope.attributesList[attrIndex];
    }

    $scope.getCurrentComp = function(comp_id) {
      compIndex = getIndexById(comp_id, $scope.attributesList);
      $scope.currentComponent = $scope.componentsList[compIndex];
    }



    $scope.cellCapList = function(capabilities) {
      $scope.capsInCell = capabilities;
    }


    $scope.getCellCapabilities = function(attr_id, comp_id) {
      var a = [];
      for (var i = 0; i < $scope.projectMaps.length; i++) {
        if ($scope.projectMaps[i].attribute_id === attr_id && $scope.projectMaps[i].component_id === comp_id) {
          cap = getIndexById($scope.projectMaps[i].capability_id, $scope.projectCapabilities);
          a.push($scope.projectCapabilities[cap]);
        }
      }
      $scope.colorCell(a);
      $scope.a = a;
      return a;
    }

    $scope.colorCell = function(caps) {
      var result = true;
      for (var i = 0; i < caps.length; i++) {
        tmp = caps[i].last_result;
        result = result && tmp;
      }
      if (caps.length == 0){
        $scope.cellColor = 'dodgerblue';
      }
      else if (result) {
        $scope.cellColor = 'forestgreen';
      }
      else if (!result) {
        $scope.cellColor = 'firebrick';
      }
    }
    /*
    getIndexById takes an id & an array, and returns the index
    of the object with this id. Returns location of object
    instead of object for grid organization
    */
    function getIndexById(id, myArray) {
      var myIndex;
      myArray.filter(function(obj) {
        if(obj.id == id) {
          myIndex = myArray.indexOf(obj);
        }
      });
      return myIndex;
    };

    $scope.showCapList = function() {
      $scope.showCaps = true;
    }
    $scope.hideCapList = function() {
      $scope.showCaps = false;
    }

    $scope.toggleEditing = function (capability) {
      if (capability.editing) {
        capability.editing = false;
      } else {
        capability.editing = true;
      }
    }

    $scope.history = [];
    $scope.getHistory = function(capability) {
      console.log("starting history")
      $http({
        method: 'GET',
        url: '/capabilites/results/' + capability.id
      }).success(function (data) {
        $scope.history = data;
      }).error(function() {window.console && console.log("Could not get history")})
    }

}]);
