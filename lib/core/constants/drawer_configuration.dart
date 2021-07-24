import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pets_app/ui/screens/menu/data/menu_item_model.dart';

Color primaryGreen = Color(0xff416d6d);
List<BoxShadow> shadowList = [
  BoxShadow(color: (Colors.grey[300])!, blurRadius: 30, offset: Offset(0, 10))
];

List<Map> categories = [
  {'name': 'Cats', 'iconPath': 'assets/images/cat.png'},
  {'name': 'Dogs', 'iconPath': 'assets/images/dog.png'},
  {'name': 'Bunnies', 'iconPath': 'assets/images/rabbit.png'},
  {'name': 'Parrots', 'iconPath': 'assets/images/parrot.png'},
  {'name': 'Horses', 'iconPath': 'assets/images/horse.png'}
];

const List<MenuItemModel> menuItemsList = [
  MenuItemModel(
      menuItemIndex: 0,
      menuItemTitle: "Adoption",
      menuItemIcon: FontAwesomeIcons.paw),
  MenuItemModel(
      menuItemIndex: 1,
      menuItemTitle: "Donation",
      menuItemIcon: FontAwesomeIcons.home),
  MenuItemModel(
      menuItemIndex: 2,
      menuItemTitle: "Add pet",
      menuItemIcon: FontAwesomeIcons.plus),
  MenuItemModel(
      menuItemIndex: 3,
      menuItemTitle: "Favorites",
      menuItemIcon: FontAwesomeIcons.heart),
  MenuItemModel(
      menuItemIndex: 4,
      menuItemTitle: "Profile",
      menuItemIcon: FontAwesomeIcons.userAlt),
];
