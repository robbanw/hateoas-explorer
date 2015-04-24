describe 'explorerController', ->
  beforeEach module 'app'

  beforeEach inject (@$location, @$httpBackend, $controller, $rootScope, $route, $modal, LinkParser) ->
    scope = $rootScope.$new()
    @explorerController = $controller('explorerController',
      $scope: scope
      $route: $route
      $location: @$location
      $modal: $modal
      response: ""
      options: ""
      linkParser: undefined
      )

  it 'should redirect to landing page', ->
    spyOn(@$location, 'path')
    @explorerController.goToHome()
    expect(@$location.path).toHaveBeenCalledWith('/')

