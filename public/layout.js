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
      }).success(function(response) { $scope.project = response; $scope.getAttributes(id); $scope.getComponents(id); $scope.getProjectCapabilities(id); $scope.getMap(id); $scope.fillTable() })
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
      }).success(function(response) { $scope.projectCapabilities = response; $scope.fillTable() })
      .error(function() { console.log("error returning capabilities") });
    }
    // $scope.addCapability = function(proj_id, attr_id, comp_id) {
    //   $http({
    //     method: 'POST',
    //     url: '/projects/'+proj_id+'/attr/'+attr_id+'/comp/'+comp_id,
    //     data: [ "name"=> this.newCapName "attribute_id"=> attr_id, "component_id"=> comp_id, "project_id"=> proj_id ]
    //   }).success(function() { console.log("added capability!") })
    //   .error(function() { console.log("error adding capability") });
    // }
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
    /*
    getCellCapabilities takes an attribute id & component id to
    search the projectMaps array for an occurrence of intersection.
    When this occurs, the capability id is identified, then
    located in the projectCapabilities array, where the capability
    is then added to a unique array capsInCell. This occurs for
    every capability match for a given attribute and component,
    and the array of all hits is returned.
    */
    $scope.capsInCell = [];
    $scope.getCellCapabilities = function(attr, comp) {
      var capsInCell = [];
      for (var i = 0; i < $scope.projectMaps.length; i++) {
        if ($scope.projectMaps[i].attribute_id == $scope.attributesList[attr].id && $scope.projectMaps[i].component_id == $scope.componentsList[comp].id) {
          cap = getById($scope.projectMaps[i].capability_id, $scope.projectCapabilities);
          capsInCell.push($scope.projectCapabilities[cap]);
        }
      }
      $scope.capsInCell = capsInCell;
      console.log("$scope.capsInCell: " + $scope.capsInCell.length)
      return capsInCell;
    }
    /*
    getById takes an id & an array, and returns the index
    of the object with this id. Returns location of object
    instead of object for grid organization
    */
    function getById(id, myArray) {
      myArray.filter(function(obj) {
        if(obj.id == id) {
          myIndex = myArray.indexOf(obj);
        }
      });
      return myIndex;
    };
    // Fill table
    $scope.fillTable = function() {
      table = document.getElementById("grid");
      numberRows = table.rows;
      console.log("attributeList.length: " + $scope.attributesList.length);
      console.log("projectMaps.length: " + $scope.projectMaps.length);

      for (var r = 1; r < numberRows.length; r++) {
        for (var c = 1; c < numberRows[r].cells.length; c++) {
          var comp_id = $scope.componentsList[r-1].id;
          var attr_id = $scope.attributesList[c-1].id;
          comp = getById(comp_id, $scope.projectCapabilities);
          attr = getById(attr_id, $scope.projectCapabilities);
          // console.log("comp: "+comp+" attr: "+attr)
          myCaps = $scope.getCellCapabilities(attr, comp);
          console.log("comp: "+comp+" attr: "+attr+" myCaps.length: "+myCaps.length);
          currentAttribute = $scope.attributesList[attr];
          currentComponent = $scope.componentsList[comp];
          capLink = "<a href=\"\" ng-click=\"buildCapList("+currentAttribute+","+ currentComponent+")\">" + myCaps.length + "</a>";
          document.getElementById("grid").rows[r].cells[c].innerHTML = capLink;
          // $scope.buildCapList(currentAttribute, currentComponent);
          // document.getElementById("caps").innerHTML =
        }
      }
    }
    $scope.buildCapList = function (attr, comp) {
      capList = "<tr><th>Attribute: " + attr.name + "</th><th>Component: " + comp.name + "</th></tr>";
      capList += "<tr ng-repeat=\"capability in capsInCell\"><th>{{capability.name}}</th></tr>"

      console.log("currentAttribute: "+currentAttribute.name+" currentComponent: "+currentComponent.name)
      // document.getElementById("caps").innerHTML = capList;
    }
  }
]);
