import 'package:flutter/material.dart';

class UpdateProvider with ChangeNotifier {
  update() {
    notifyListeners();
  }
}
