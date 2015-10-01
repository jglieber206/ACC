var angular = require('angular');
var app = require('../app.js')

app.controller('CapabilitiesController', ['$scope', '$http', '$rootScope', function ($scope, $http, $rootScope) {

    $scope.addCapability = function(newCapability, proj_id) {
      $http({
        method: 'POST',
        url: '/attributes/'+$scope.currentAttribute.id+'/components/'+$scope.currentComponent.id,
        data: {
          name: newCapability.capabilityName,
          project_id: proj_id,
          code: newCapability.capabilityCode,
          url: newCapability.capabilityUrl,
          oauth: newCapability.capabilityOauth
        }
      }).success(function(response) { $scope.capsInCell.push(response) })
      .error(function() { console.log("error adding capability") });
    }

    $scope.updateCapability = function(capability) {
      $http({
        method: 'POST',
        url: '/capabilities/update/' + capability.id,
        data: { name: capability.name, code: capability.code, url: capability.url, oauth: capability.oauth }
      }).success(function(response) {
        console.log("response before:", response);
        console.log("capability before:", capability);
        $scope.capsInCell.splice($scope.capsInCell.indexOf(capability), 1)
        $scope.capsInCell.push(response)
        console.log("response after:", response);
        console.log("capability after:", capability);
      })
      .error(function() { console.log("error adding capability") });
    }

    $scope.deleteCapability = function(capability) {
      $http({
        method: 'DELETE',
        url: '/capabilities/' + capability.id
      })
      .success(function(capability) {
        $scope.capsInCell.splice($scope.capsInCell.indexOf(capability), 1)
       })
      .error(function() { console.log("error deleting capability") })
    }

    $scope.currentAttribute = null;
    $scope.currentComponent = null;

    $scope.getCurrentAttr = function(attr_id) {
      attrIndex = getIndexById(attr_id, $scope.attributesList);
      $scope.currentAttribute = $scope.attributesList[attrIndex];
    }

    $scope.getCurrentComp = function(comp_id) {
      compIndex = getIndexById(comp_id, $scope.attributesList);
      $scope.currentComponent = $scope.componentsList[compIndex];
    }


    $scope.capsInCell = [];
    $scope.cellCapList = function(capabilities) {
      $scope.capsInCell = capabilities;
    }

    $scope.a = [];
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
        // console.log("tmp: "+tmp+" Cap: "+caps[i].name)
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
      // console.log("result: "+result)
      // return $scope.cellColor;
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
        capability.name = capability.oldName;
        capability.code = capability.oldCode;
        capability.url = capability.oldUrl;
        capability.oauth = capability.oldOauth;
        capability.editing = false;
      } else {
        capability.oldName = capability.name;
        capability.oldCode = capability.code;
        capability.oldUrl = capability.url;
        capability.oldOauth = capability.oauth;
        capability.editing = true;
      }
    }

}]);
