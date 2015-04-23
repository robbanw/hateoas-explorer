class AutoRoutes extends Config
  constructor: ($routeProvider) ->
    $routeProvider
    .when '/explorer/discovery/auto/:url',
      caption: 'Auto'
      controller: 'autoController'
      controllerAs: 'auto'
      templateUrl: 'explorer/auto/auto.html'
      resolve:{
        linkParser: (LinkParser) ->
          new LinkParser
      }
