;(function() {
"use strict"

appModule('app.user')
  .factory('UserService', function ($injector, APP) {
    if (APP.devMode) {
      return $injector.get('UserServiceMockImpl')
    } else {
      // Firebase implementation
      return $injector.get('UserServiceFirebaseImpl')
    }
  })
}())
