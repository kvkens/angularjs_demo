'use strict';

angular.module('emmFrontendApp')
  .factory('Session', function ($resource) {
    return $resource('/api/session/');
  });
