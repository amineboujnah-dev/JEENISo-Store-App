import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pets_app/ui/screens/menu/data/menu_item_model.dart';

Color primaryGreen = Color.fromRGBO(53, 148, 214, 1);
List<BoxShadow> shadowList = [
  BoxShadow(color: (Colors.grey[300])!, blurRadius: 30, offset: Offset(0, 10))
];

const List<MenuItemModel> menuItemsList = [
  MenuItemModel(
      menuItemIndex: 0,
      menuItemTitle: "Home",
      menuItemIcon: FontAwesomeIcons.home),
  MenuItemModel(
      menuItemIndex: 1,
      menuItemTitle: "Favorites",
      menuItemIcon: FontAwesomeIcons.solidHeart),
  MenuItemModel(
      menuItemIndex: 2,
      menuItemTitle: "Profile",
      menuItemIcon: FontAwesomeIcons.userAlt),
];
