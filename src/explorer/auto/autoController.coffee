class Auto extends Controller
  constructor: ($scope, $routeParams, $q, @$location, linkParser, apiService, $modal) ->
    $scope.url = decodeURIComponent($routeParams.url)
    g = new Graph
    layouter = new Graph.Layout.Spring(g)
    renderer = new Graph.Renderer.Raphael('canvas', g, 1000, 800);

    $scope.draw = () ->
      layouter.layout()
      renderer.draw()

    $scope.openResizeModal = () ->
      options =
        templateUrl: "/explorer/auto/resize/resizeModal.html",
        controller: "resizeModalController"
      modalActionInstance = $modal.open(options)
      modalActionInstance.result.then((size) ->
        # Unfortunately we need to create a new copy of the graph since graphdracula saves some state
        g1 = new Graph
        for edge in g.edges
          g1.addEdge(edge.source.id, edge.target.id, {directed: true})
        angular.element(document.querySelector('#canvas')).empty()
        layouter = new Graph.Layout.Spring(g1)
        renderer = new Graph.Renderer.Raphael('canvas', g1, size.width, size.height);
        $scope.draw()
        )

    visited = {}
    apiService.get($scope.url).then((res) ->
      addEdges = (url, response) ->
        leaf = true
        deferred = $q.defer()
        promises = [deferred.promise]
        if not visited[url]
          visited[url] = true
          if 'links' of response.data
            leaf = false
            for link in response.data.links
              g.addEdge(url.substring($scope.url.length, url.length), link.href.substring($scope.url.length, link.href.length), {directed: true})
              promises.push(apiService.get(link.href))
          if '_links' of response.data
            leaf = false
            for link of response.data._links
              g.addEdge(url.substring($scope.url.length, url.length), link.substring($scope.url.length, link.length), {directed: true})
              promises.push(apiService.get(link))
          for element of response.data
            if element isnt 'links' and element isnt'_links' and typeof(response.data[element]) is 'object' and response.data[element]
              linkedObjs = []
              linkParser.extractLinkedObjs(response.data[element], linkedObjs)
              leaf = false if linkedObjs.length
              for link in linkedObjs
                g.addEdge(url.substring($scope.url.length, url.length), link.url.substring($scope.url.length, link.url.length), {directed: true})
                promises.push(apiService.get(link.url))
        deferred.resolve()
        $q.all(promises).then((values) ->
          angular.forEach(values, (value) ->
            addEdges(value.url, value) if value))

      addEdges(res.url, res, undefined).then((dummy) ->
        $scope.draw()))

  goToHome: ->
    @$location.path('/')

