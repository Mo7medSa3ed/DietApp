import 'package:flutter/foundation.dart';

class AppProvider extends ChangeNotifier {
  int index = 0;
  var user ;
  int cartCount=0;

    
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
