class Explorer extends Controller
  constructor: ($scope, @$route, $routeParams, @$location, response, @options) ->
    $scope.url = decodeURIComponent($routeParams.url)
    $scope.status = response.status
    $scope.data = response.data
    $scope.raw = JSON.stringify(response.data, null, 2)
    $scope.rawHeaders = JSON.stringify(response.headers(), null, 2)
    $scope.locationHeader = response.headers('location')
    @linkedObjs = []
    for element of response.data
      if element isnt 'links' and typeof(response.data[element]) is 'object' and response.data[element]
        @extractLinkedObjs(response.data[element])

  follow: (url) ->
    @$location.path('explorer/' + encodeURIComponent(url))

  goToHome: ->
    @$location.path('/')

  getLabel: (option) ->
    switch option
      when 'GET' then 'btn btn-lg btn-primary'
      when 'POST' then 'btn btn-lg btn-success'
      when 'DELETE' then 'btn btn-lg btn-danger'
      when 'PUT' then 'btn btn-lg btn-warning'
      when 'PATCH' then 'btn btn-lg btn-info'
      else 'btn btn-lg btn-default'

  getAction: (option) ->
    switch option
      when 'GET' then @$route.reload()

  extractLinkedObjs: (data) ->
    if 'links' of data
      linkedObj = {}
      linkedObj.raw = JSON.stringify(data, null, 2)
      for link in data.links
        if link.rel is 'self'
          linkedObj.url = link.href
          @linkedObjs.push(linkedObj)
          break
    for element of data
      if element isnt 'links' and typeof(data[element]) is 'object' and data[element]
        @extractLinkedObjs(data[element])
