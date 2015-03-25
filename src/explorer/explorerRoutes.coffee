class ExplorerRoutes extends Config
  constructor: ($routeProvider) ->
    $routeProvider
    .when '/explorer/:url',
      caption: 'Explorer'
      controller: 'explorerController'
      controllerAs: 'explorer'
      templateUrl: 'explorer/explorer.html'
      resolve: {
        response: ($route, apiService) ->
          apiService.get(decodeURIComponent($route.current.params.url))
        options: ($route, apiService) ->
          apiService.options(decodeURIComponent($route.current.params.url))
      }
