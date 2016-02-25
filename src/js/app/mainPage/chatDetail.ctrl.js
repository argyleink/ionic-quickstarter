;(function() {
"use strict"

var ChatDetailCtrl = /*@ngInject*/function ($stateParams, Chats) {
  var vm = this
  vm.chat = Chats.get($stateParams.chatId)
}

appModule('app.mainPage').controller('ChatDetailCtrl', ChatDetailCtrl)
}())
