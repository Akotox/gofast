import 'package:flutter/material.dart';

class MyData extends ChangeNotifier {
  bool _acceptedState = false;

  bool get changes => _acceptedState;

  set changes(bool value) {
    _acceptedState = value;
    notifyListeners();
  }
}