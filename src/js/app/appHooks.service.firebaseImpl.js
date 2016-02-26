(function() {
"use strict"

appModule('app.hooks')
  // Firebase implementation of the AppHooks service'.
  .factory('AppHooksFirebaseImpl', function () {
    // Generic hook function, called when the user is "loaded" (after login) or "unloaded". If more stuff needs to be loaded/unloaded or other things need to be done after logging in or out then you can place them here.
    // potential inbound param: fbutil

    var loadUnloadUser = function () {
      // potential inbound params: userService, user, load
      // nothing here, at the moment
    }

    return {
      loadUnloadUser: loadUnloadUser
    }
  })
}())
