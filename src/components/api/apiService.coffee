class Api extends Service
  constructor: (@$http) ->

  get: (url) ->
    @$http.get(url).then(
      (response) ->
        response.url = url
        response.error = false
        response
      (response) ->
        response.url = url
        response.error = true
        response
      )

  delete: (url) ->
    @$http.delete(url).then(
      (response) ->
        response.error = false
        response
      (response) ->
        response.error = true
        response
      )

  options: (opurl) ->
    optionsInfo = {}
    @$http({method: "OPTIONS", url: opurl}).success((data, status, headers, config) ->
      optionsInfo.arr = headers('Allow').replace(/\s/g, '').split(",").sort())
    optionsInfo

  post: (url, body) ->
    @$http.post(url, body).then(
      (response) ->
        response.error = false
        response
      (response) ->
        response.error = true
        response
      )

  put: (url, body) ->
    @$http.put(url, body).then(
      (response) ->
        response.error = false
        response
      (response) ->
        response.error = true
        response
      )

  patch: (url, body) ->
    @$http.patch(url, body).then(
      (response) ->
        response.error = false
        response
      (response) ->
        response.error = true
        response
      )



