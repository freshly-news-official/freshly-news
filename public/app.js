var app = angular.module('app', []);

app.controller('FreshlyController', ['$scope', '$http', function($scope, $http) {
   $scope.search_results = [];

    $scope.search = function() {
      /* the $http service allows you to make arbitrary ajax requests.
       * in this case you might also consider using angular-resource and setting up a
       * User $resource. */
       /*/search este endpoint-ul definit de baieti*/
      $http.get('/search', { 'search_term': $scope.search_term },
        function(response) { $scope.search_results = response; },
        function(failure) { console.log("failed :(", failure); });
    });
  });