import 'package:flutter/foundation.dart';

class AppProvider extends ChangeNotifier {
  int index = 0;
  var user;
  int cartCount = 0;
  List chatList = [];

  initChatList(chatList) {
    this.chatList = chatList;
    notifyListeners();
  }

  addToChatList(message) {
    this.chatList.add(message);
    notifyListeners();
  }

  initUser(user) {
    this.user = user;
    notifyListeners();
  }

  changeCartCount(cartCount) {
    this.cartCount = cartCount;
    notifyListeners();
  }

  changeIndex(i) {
    index = i;
    notifyListeners();
  }
}
