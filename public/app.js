var app = angular.module('app', []);

app.controller('FreshlyController', ['$scope', '$http', function($scope, $http) {

   $scope.news_items = function(element) {
    $http.get(element)
      .success(function(data, status, headers, config) {
        $scope.news_items_to_show = data;
        $scope.show_items = true;

      })
   };

   $scope.search_results = [];
   $scope.news_items_to_show = [];
   $scope.categories = [];
   $scope.show_items = true;
   $scope.news_items('/news/random');
  
    $http.get('/categories')
      .success(function(data, status, headers, config) {
        $scope.categories = data;
      })
      .error(function(data, status, headers, config) {
        console.log("failed :(");
     });
      

  $scope.search = function() {
  $http.post('/search', { 'search_term': $scope.search_term })
    .success(function(data, status, headers, config) {
      $scope.search_results = data;
      $scope.show_items = false;
      $scope.search_term ='';
    })
    .error(function(data, status, headers, config) {
      console.log("failed :(");
    });
  };




  $scope.retrieve_news_items_to_show = function() {
    return $scope.news_items_to_show;
  };

}]);
var app = angular.module('app', []);

app.controller('FreshlyController', ['$scope', '$http', function($scope, $http) {

   $scope.news_items = function(element) {
    $http.get(element)
      .success(function(data, status, headers, config) {
        $scope.news_items_to_show = data;
        $scope.show_items = true;

      })
   };

   $scope.search_results = [];
   $scope.news_items_to_show = [];
   $scope.categories = [];
   $scope.show_items = true;
   $scope.news_items('/news/random');
  
    $http.get('/categories')
      .success(function(data, status, headers, config) {
        $scope.categories = data;
      })
      .error(function(data, status, headers, config) {
        console.log("failed :(");
     });
      

  $scope.search = function() {
  $http.post('/search', { 'search_term': $scope.search_term })
    .success(function(data, status, headers, config) {
      $scope.search_results = data;
      $scope.show_items = false;
      $scope.search_term ='';
    })
    .error(function(data, status, headers, config) {
      console.log("failed :(");
    });
  };




  $scope.retrieve_news_items_to_show = function() {
    return $scope.news_items_to_show;
  };

}]);
