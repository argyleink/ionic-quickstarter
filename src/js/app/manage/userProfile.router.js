(function() {
"use strict"

appModule('app.manage')
  .config(function ($stateProvider) {
    $stateProvider
      .state('app.auth.userProfile', {
        url: '/userProfile',
        views: {
          'menuContent@app': {
            templateUrl:  'js/app/manage/userProfile.html',
            controller:   'UserProfileCtrl as vm'
          }
        }
      })
    })
}())
