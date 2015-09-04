var accApp = angular.module('accApp', []);
accApp.controller('ProjectCtrl', ['$scope', '$http', function ($scope, $http) {
    $scope.projectList = [];
    $scope.getProjects = function() {
      $http({
        method: 'GET',
        url: '/projects'
      }).success(function(response) { $scope.projectList = response })
      .error(function() { console.log("error") });
    }

    // Project methods
    $scope.project = [];
    $scope.openProject = function(id) {
      $http({
        method: 'GET',
        url: '/projects/' + id
      }).success(function(response) { $scope.project = response; $scope.getAttributes(id); $scope.getComponents(id); $scope.getProjectCapabilities(id); $scope.getMap(id) })
      .error(function() { console.log("error") });
    }
    $scope.addProject = function() {
      $http({
        method: 'POST',
        url: '/projects',
        data: this.newProject
      }).success(function() { console.log("added project!") })
      .error(function() { console.log("error") });
    }
    $scope.deleteProject = function(id) {
      $http({
        method: 'DELETE',
        url: '/projects/' + id
      }).success(function(project) { console.log(project) })
      .error(function() { console.log("error") });
    }

    // Attribute methods
    $scope.attributesList = [];
    $scope.getAttributes = function(id) {
      $http({
        method: 'GET',
        url: '/projects/' + id + '/attributes'
      }).success(function(response) { $scope.attributesList = response })
      .error(function() { console.log("error") });
    }
    $scope.addAttribute = function(id) {
      $http({
        method: 'POST',
        url: '/projects/' + id + '/attributes',
        data: this.newAttribute
      }).success(function() { console.log("Added attribute") })
      .error(function() { console.log("error") });
    }
    $scope.deleteAttribute = function(id) {
      $http({
        method: 'DELETE',
        url: '/attributes/' + id
      }).success(function() { console.log("Attribute deleted") })
      .error(function() { console.log("error") });
    }

    // Component methods
    $scope.componentsList = [];
    $scope.getComponents = function(id) {
      $http({
        method: 'GET',
        url: '/projects/' + id + '/components'
      }).success(function(response) { $scope.componentsList = response })
      .error(function() { console.log("error") });
    }
    $scope.addComponent = function(id) {
      $http({
        method: 'POST',
        url: '/projects/' + id + '/components',
        data: this.newComponent
      }).success(function() { console.log("added component!") })
      .error(function() { console.log("error") });
    }
    $scope.deleteComponent = function(id) {
      $http({
        method: 'DELETE',
        url: '/components/' + id
      }).success(function() { console.log("Component deleted") })
      .error(function() { console.log("error") });
    }

    // Capability methods
    $scope.projectCapabilities = [];
    $scope.getProjectCapabilities = function(id) {
      $http({
        method: 'GET',
        url: '/projects/' + id + '/capabilities'
      }).success(function(response) { $scope.projectCapabilities = response })
      .error(function() { console.log("error returning capabilities") });
    }
    $scope.addCapability = function(proj_id, attr_id, comp_id) {
      $http({
        method: 'POST',
        url: '/projects/'+proj_id+'/attr/'+attr_id+'/comp/'+comp_id,
        data: { name: this.newCapName, attribute_id: attr_id, component_id: comp_id, project_id: proj_id }
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
    $scope.projectMaps = [];
    $scope.getMap = function(id) {
      $http({
        method: 'GET',
        url: '/projects/' + id + '/capability_maps'
      }).success(function(response) { $scope.projectMaps = response });
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
    // $scope.currentAttribute = null;
    $scope.getCurrentAttr = function(attr_id) {
      attrIndex = getIndexById(attr_id, $scope.attributesList)
      $scope.currentAttribute = $scope.attributesList[attrIndex]
    }
    // $scope.currentComponent = null;
    $scope.getCurrentComp = function(comp_id) {
      compIndex = getIndexById(comp_id, $scope.componentsList)
      $scope.currentComponent = $scope.componentsList[compIndex]
    }
    $scope.capsInCell = [];
    $scope.cellCapList = function(capabilities) {
      $scope.capsInCell = capabilities;
    }
    $scope.colorCell = function(caps) {
      var result = true;
      for (var i = 0; i < caps.length; i++) {
        tmp = caps[i].last_result;
        console.log("tmp: "+tmp+" Cap: "+caps[i].name)
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
      console.log("result: "+result)
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
      console.log("showCaps: " + $scope.showCaps)
    }
    $scope.hideCapList = function() {
      $scope.showCaps = false;
      console.log("showCaps: "+$scope.showCaps)
    }

  }
]);
