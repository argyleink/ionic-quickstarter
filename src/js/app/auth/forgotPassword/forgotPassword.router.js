(function() {
"use strict"

appModule('app.auth.forgotPassword')
  .config(function ($stateProvider) {
    $stateProvider
      .state('forgotPassword', {
        url:          '/forgotPassword',
        templateUrl:  'js/app/auth/forgotPassword/forgotPassword.html',
        controller:   'ForgotPasswordCtrl as vm'
      })
  })
}())
