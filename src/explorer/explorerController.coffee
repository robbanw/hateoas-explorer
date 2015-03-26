class Explorer extends Controller
  constructor: (@$scope, @$route, $routeParams, @$location, $modal, response, @options) ->
    @$scope.url = decodeURIComponent($routeParams.url)
    @$scope.status = response.status if not @$scope.status or overwrite
    @$scope.data = response.data if not @$scope.data or overwrite
    @$scope.raw = JSON.stringify(response.data, null, 2)
    if response.headers
      @$scope.rawHeaders = JSON.stringify(response.headers(), null, 2) if not @$scope.rawHeaders or overwrite
      @$scope.locationHeader = response.headers('location') if not @$scope.locationHeader or overwrite
    @$scope.linkedObjs = []
    for element of response.data
      if element isnt 'links' and typeof(response.data[element]) is 'object' and response.data[element]
        @extractLinkedObjs(response.data[element])

  follow: (url) ->
    @$location.path('explorer/' + encodeURIComponent(url) + '/GET')

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
      when 'DELETE' then @$location.path('explorer/' + encodeURIComponent(@$scope.url) + '/DELETE')
      when 'OPTIONS' then @$scope.optionsAlert = "The OPTIONS request for this URL returned the verbs that you see as buttons below"
      else @$scope.noActionAlert = "HATEOAS Explorer has no action implemented for this verb"

  closeAlert: (alert) ->
    @$scope[alert] = null

  extractLinkedObjs: (data) ->
    if 'links' of data
      linkedObj = {}
      linkedObj.raw = JSON.stringify(data, null, 2)
      for link in data.links
        if link.rel is 'self'
          linkedObj.url = link.href
          @$scope.linkedObjs.push(linkedObj)
          break
    for element of data
      if element isnt 'links' and typeof(data[element]) is 'object' and data[element]
        @extractLinkedObjs(data[element])
