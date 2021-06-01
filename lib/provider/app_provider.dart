import 'package:flutter/foundation.dart';

class AppProvider extends ChangeNotifier {
 int index = 0;

  changeIndex(i) {
    index = i;
    notifyListeners();
  }
}

