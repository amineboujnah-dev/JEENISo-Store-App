import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/controllers/simple_hidden_drawer_controller.dart';
import 'package:hidden_drawer_menu/simple_hidden_drawer/animated_drawer_content.dart';
import 'package:hidden_drawer_menu/simple_hidden_drawer/simple_hidden_drawer.dart';
import 'package:pets_app/ui/screens/Profile/Profile%20Details/view/profile_details_view.dart';
import 'package:pets_app/ui/screens/home/widgets/homeScreen.dart';
import 'package:pets_app/ui/screens/menu/widgets/menu_list_widget.dart';
import 'package:pets_app/ui/ui_utils/config_setup/size_config.dart';

class MenuView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sizedConfig = SizeConfig();
    sizedConfig.init(context);
    return SimpleHiddenDrawer(
      verticalScalePercent: sizedConfig.getProportionateScreenWidth(60),
      slidePercent: sizedConfig.getProportionateScreenWidth(60),
      menu: MenuListWidget(),
      screenSelectedBuilder:
          (position, SimpleHiddenDrawerController controller) {
        Widget? screenCurrent = HomeScreen();
        switch (position) {
          case 0:
            {
              screenCurrent = HomeScreen();
            }
            break;
          case 4:
            {
              screenCurrent = ProfileView();
            }
            break;
        }
        return screenCurrent;
      },
      withShadow: true,
      contentCornerRadius: 25,
      enableCornerAnimation: true,
      enableScaleAnimation: true,
      curveAnimation: Curves.easeInBack,
      isDraggable: true,
      initPositionSelected: 0,
      typeOpen: TypeOpen.FROM_LEFT,
    );
  }
}