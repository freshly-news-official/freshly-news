var app = angular.module('app', []);

app.controller('FreshlyController', ['$scope', '$http', function($scope, $http) {
   $scope.search_results = [];
   $scope.news = [];
   $scope.categories = [];
   $scope.news_category = [];
   $scope.show_top_news = true;
   $scope.show_all = false;
   $scope.show_bool_category = false;
   $scope.show_search = false;
   

    $http.get('/categories')
      .success(function(data, status, headers, config) {
        $scope.categories = data;
      })
      .error(function(data, status, headers, config) {
        console.log("failed :(");
     });
    

    $http.get('/news/random')
      .success(function(data, status, headers, config) {
        $scope.news = data;
      })
      .error(function(data, status, headers, config) {
        console.log("failed :(");
     });
    
    $scope.search = function() {
       /*/search este endpoint-ul definit de baieti*/
    $http.post('/search', { 'search_term': $scope.search_term })
      .success(function(data, status, headers, config) {
        $scope.search_results = data;
        $scope.show_top_news = false;
     $scope.show_all = false;
     $scope.show_bool_category = false;
     $scope.show_search = true;
      })
      .error(function(data, status, headers, config) {
        console.log("failed :(");
    });
  };

  $scope.show_home = function() {
       /*/search este endpoint-ul definit de baieti*/
     $http.get('/news/random')
      .success(function(data, status, headers, config) {
        $scope.news = data;
        $scope.show_top_news = true;
        $scope.show_all = false;
        $scope.show_bool_category = false;
        $scope.show_search = false;
      })
      .error(function(data, status, headers, config) {
        console.log("failed :(");
     });
  };

  $scope.show_category = function(category) {
       /*/search este endpoint-ul definit de baieti*/
    $http.get('/news/' + category)
      .success(function(data, status, headers, config) {
        $scope.news_category = data;
        $scope.show_bool_category = true;
        $scope.show_top_news = false;
        $scope.show_all = false;
        $scope.show_search = false;
      })
      .error(function(data, status, headers, config) {
        console.log("failed :(");
    });
  };

  $scope.show_all = function() {
       /*/search este endpoint-ul definit de baieti*/
    $http.get('/news/all')
      .success(function(data, status, headers, config) {
        $scope.news_all = data;
        $scope.show_bool_category = false;
        $scope.show_top_news = false;
        $scope.show_all = true;
        $scope.show_search = false;

      })
      .error(function(data, status, headers, config) {
        console.log("failed :(");
    });
  };

}]);
