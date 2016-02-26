(function() {
"use strict"
appModule('app.util')
  .factory('TrackingServiceDummyImpl', function () {
    var trackEvent = function () {
      // potential inbound params: logLevel, message
      // do nothing  :-)
    }

    return {
      trackEvent: trackEvent
    }
  })
}())
