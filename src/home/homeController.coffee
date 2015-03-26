class Home extends Controller
	constructor: ($scope, $location, scriptService) ->
    scripts  = scriptService.get()
    @scripts = (script for script in scripts when script.indexOf('/vendor/') isnt 0)
    $scope.submit = ->
      $location.path('explorer/' + encodeURIComponent(this.url.text) + '/GET')
