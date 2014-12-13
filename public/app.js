var app = angular.module('app', []);

app.controller('FreshlyController', ['$scope', '$http', function($scope, $http) {
   $scope.search_results = [];
   $scope.news = [];

    $scope.search = function() {
       /*/search este endpoint-ul definit de baieti*/
    $http.post('/search', { 'search_term': $scope.search_term })
      .success(function(data, status, headers, config) {
        $scope.search_results = data;
      })
      .error(function(data, status, headers, config) {
        console.log("failed :(", failure);
    });
  };
}]);
