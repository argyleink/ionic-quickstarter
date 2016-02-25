(function() {
"use strict"
appModule('app.hooks')
  // 'Mock' implementation of the AppHooks service'.
  .factory('AppHooksMockImpl', function () {
    // Generic hook function, called when the user is "loaded" (after login) or "unloaded". If more stuff needs to be
    // loaded/unloaded or other things need to be done after logging in or out then you can place them here.
    var loadUnloadUser = function (userService, user, load) {
      // nothing here, at the moment
    }

    return {
      loadUnloadUser: loadUnloadUser
    }
  })
}())
