class ExplorerRoutes extends Config
  constructor: ($routeProvider) ->
    $routeProvider
    .when '/explorer/:url/:verb',
      caption: 'Explorer'
      controller: 'explorerController'
      controllerAs: 'explorer'
      templateUrl: 'explorer/explorer.html'
      resolve: {
        response: ($route, apiService) ->
          switch $route.current.params.verb
            when 'GET' then apiService.get(decodeURIComponent($route.current.params.url))
            when 'DELETE' then apiService.delete(decodeURIComponent($route.current.params.url))
        options: ($route, apiService) ->
          apiService.options(decodeURIComponent($route.current.params.url))
      }
