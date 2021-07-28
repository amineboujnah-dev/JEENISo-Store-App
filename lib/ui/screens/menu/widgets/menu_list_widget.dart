import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pets_app/core/providers/authentication_provider.dart';
import 'package:pets_app/ui/screens/menu/widgets/menu_list_item.dart';
import 'package:pets_app/ui/ui_utils/config_setup/size_config.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/drawer_configuration.dart';

class MenuListWidget extends StatefulWidget {
  @override
  _MenuListWidgetState createState() => _MenuListWidgetState();
}

class _MenuListWidgetState extends State<MenuListWidget> {
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthProvider>(context);
    final sizeConfig = SizeConfig();
    sizeConfig.init(context);
    return Scaffold(
      body: Container(
        height: sizeConfig.screenHeight,
        width: sizeConfig.screenWidth,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color.fromRGBO(70, 112, 112, 1.0),
              Color.fromRGBO(48, 96, 96, 1.0)
            ])),
        child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: menuItemsList.length + 2,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: EdgeInsets.only(
                      top: sizeConfig.getProportionateScreenWidth(24),
                      left: sizeConfig.getProportionateScreenWidth(20),
                      bottom: sizeConfig.screenHeight * 0.1),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 24.0,
                        backgroundImage:
                            AssetImage('assets/images/adopt_me_logo.png'),
                      ),
                      SizedBox(
                        width: 16.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'User User',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 22.0,
                            ),
                          ),
                          Text(
                            'Active status',
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.5)),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              } else if (index !=
                  menuItemsList.indexOf(menuItemsList.last) + 2) {
                return MenuListItem(
                  menuItemModel: menuItemsList[index - 1],
                );
              } else {
                return Padding(
                  padding: EdgeInsets.only(
                      bottom: sizeConfig.getProportionateScreenWidth(20),
                      left: sizeConfig.getProportionateScreenWidth(20),
                      top: sizeConfig.screenHeight * 0.12),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.cog,
                        color: Colors.white.withOpacity(0.5),
                      ),
                      SizedBox(
                        width: 16.0,
                      ),
                      Text(
                        'Settings',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () async => await loginProvider.logout(context),
                        child: Text(
                          '   |   Log out',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }
}
