var angular = require('angular');
var app = require('../app.js')

app.controller('CapabilitiesController', ['$scope', '$http', '$rootScope', function ($scope, $http, $rootScope) {

    var my_attr = "";
    var my_comp = "";

    $scope.addCapability = function(proj_id) {
      $http({
        method: 'POST',
        url: '/attributes/'+my_attr+'/components/'+my_comp,
        data: { name: this.newCapName, project_id: proj_id, code: this.newCapCode, url: this.newCapUrl, oauth: this.newCapOauth }
      }).success(function() { console.log("added capability!") })
      .error(function() { console.log("error adding capability") });
    }

    $scope.deleteCapability = function(id) {
      $http({
        method: 'DELETE',
        url: '/capabilities/' + id
      })
      .success(function() { console.log("Capability deleted") })
      .error(function() { console.log("error deleting capability") })
    }

    $scope.getCellCapabilities = function(attr_id, comp_id) {
      var capsInCell = [];
      for (var i = 0; i < $scope.projectMaps.length; i++) {
        if ($scope.projectMaps[i].attribute_id == attr_id && $scope.projectMaps[i].component_id == comp_id) {
          cap = getIndexById($scope.projectMaps[i].capability_id, $scope.projectCapabilities);
          capsInCell.push($scope.projectCapabilities[cap]);
        }
      }
      $scope.colorCell(capsInCell);
      return capsInCell;
    }

    $scope.setAttrAndComp = function(attr_id, comp_id) {
      console.log("****************: " + attr_id + "*********" + comp_id)
      my_attr = attr_id;
      my_comp = comp_id;
      console.log(my_attr);
      console.log(my_comp);
    }


    // $scope.currentAttribute = null;
    $scope.getCurrentAttr = function(attr_id) {
      attrIndex = getIndexById(attr_id, $scope.attributesList)
      $scope.currentAttribute = $scope.attributesList[attrIndex]
    }
    // $scope.currentComponent = null;

    $scope.capsInCell = [];
    $scope.cellCapList = function(capabilities) {
      $scope.capsInCell = capabilities;
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
      // console.log("showCaps: " + $scope.showCaps)
    }
    $scope.hideCapList = function() {
      $scope.showCaps = false;
      // console.log("showCaps: "+$scope.showCaps)
    }

  }
]);
