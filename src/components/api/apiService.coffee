class Api extends Service
  constructor: (@$http) ->

  get: (url) ->
    @$http.get(url)

  delete: (url) ->
    @$http.delete(url)

  options: (opurl) ->
    optionsInfo = {}
    @$http({method: "OPTIONS", url: opurl}).success((data, status, headers, config) ->
      optionsInfo.arr = headers('Allow').replace(/\s/g, '').split(",").sort())
    optionsInfo
