class Home extends Controller
	constructor: ($scope, $location, scriptService) ->
    scripts  = scriptService.get()
    $scope.radioModel = 'Manual'
    @scripts = (script for script in scripts when script.indexOf('/vendor/') isnt 0)
    $scope.submit = ->
      if $scope.radioModel is 'Manual'
        $location.path('explorer/' + encodeURIComponent(this.url.text) + '/GET')
      else
        $location.path('explorer/discovery/auto/' + encodeURIComponent(this.url.text))
