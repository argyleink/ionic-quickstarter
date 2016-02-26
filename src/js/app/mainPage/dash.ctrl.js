(function() {
"use strict"

var DashCtrl = /*@ngInject*/function (Application, $scope) {
  // var vm    = this
  var log   = Application.getLogger('MainPageDashCtrl')

  $scope.$on('$ionicView.beforeEnter', function () {
    // potential inbound param: event, viewData
    log.debug("beforeEnter")
    // do stuff here which you want to do anytime you switch to the tab managed by this controller
    log.debug("beforeEnter end")
  })
}

appModule('app.mainPage').controller('DashCtrl', DashCtrl)
}())
