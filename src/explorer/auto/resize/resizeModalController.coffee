class ResizeModal extends Controller
  constructor: ($scope, $modalInstance) ->
    $scope.cancel = () ->
      $modalInstance.dismiss()
    $scope.resize = () ->
      size = {}
      size.width = this.width
      size.height = this.height
      $modalInstance.close(size)
