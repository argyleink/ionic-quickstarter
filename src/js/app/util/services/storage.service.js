(function() {
"use strict"

appModule('app.util')
  .factory('StorageService', function ($injector) {
    // potential inbound params: , APP
    //if (APP.devMode) {
      return $injector.get('StorageServiceLocalImpl')
    //} else {
    //  return $injector.get('StorageServiceLocalImpl')
    //}
  })
}())
