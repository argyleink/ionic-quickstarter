(function() {
"use strict"

appModule('app.util')
  .factory('TrackingService', function ($injector) {
    // potential inbound params: , APP
    //if (APP.devMode) {
      return $injector.get('TrackingServiceDummyImpl')
    //} else {
    //  return $injector.get('TrackingServiceLogentriesImpl')
    //}
  })
}())
