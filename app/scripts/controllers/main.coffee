'use strict'
app.controller 'MainCtrl', ($scope, $rootScope, $http) ->
  return

app.controller 'NavbarCtrl', ($scope, $rootScope, $location, Auth) ->
  $scope.logout = -> Auth.logout().then -> $location.path('/login')
  return

app.controller 'CrumbCtrl', ($scope, $rootScope, $location) ->
  $scope.crumb = (url) ->
    config = $rootScope.config
    return "" if config is undefined
    for menu in config.menus
      return menu.name if menu.href is url
      if menu.submenus
        for submenu in menu.submenus
          return "#{menu.name} -- #{submenu.name}" if submenu.href is url
  return

app.controller 'SidebarCtrl', ($scope, $rootScope) ->
  $scope.menus = $rootScope.config.menu
  return

app.controller 'LoginCtrl', ($scope, $rootScope, Auth, $location) ->
  $location.path '/' if Auth.isLoggedIn()
  $scope.user = {}
  $scope.errors = {}
  $scope.login = (form) ->
    $scope.submitted = true
    if form.$valid
      Auth.login({
        email: $scope.user.email
        password: $scope.user.password
      }).then( -> $location.path '/').catch( (err) -> $scope.errors.other = err.data.message)
  return

app.controller 'SignupCtrl', ($scope, Auth, $location) ->
  $location.path '/' if Auth.isLoggedIn()
  $scope.user = {}
  $scope.errors = {}
  $scope.register = (form) ->
    $scope.submitted = true
    if form.$valid
      Auth.createUser({
        name: $scope.user.name
        email: $scope.user.email
        password: $scope.user.password})
      .then( -> 
        $location.path '/')
      .catch((err)->
        angular.forEach err.data.errors, (error, field) ->
          form[field].$setValidity 'mongoose', false
          $scope.errors[field] = error.message)
  return
