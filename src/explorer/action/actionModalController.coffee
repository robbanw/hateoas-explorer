class ActionModal extends Controller
  constructor: ($scope, $modalInstance, apiService, requestType, url) ->
    $scope.requestType = requestType
    $scope.cancel = () ->
      $modalInstance.dismiss()
    $scope.makeRequest = () ->
      switch requestType
        when 'POST' then response = apiService.post(url, this.request.body)
        when 'PUT' then response = apiService.put(url, this.request.body)
        when 'PATCH' then response = apiService.patch(url, this.request.body)
      $modalInstance.close(response)
