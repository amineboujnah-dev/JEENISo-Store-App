import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/controllers/animated_drawer_controller.dart';

class MenuProvider extends ChangeNotifier {
  MenuState _menuState = MenuState.closed;

  MenuState get menuState => _menuState;

  void setMenuState(MenuState value) {
    _menuState = value;
    notifyListeners();
  }
}
