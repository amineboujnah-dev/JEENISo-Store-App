import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pets_app/core/providers/authentication_provider.dart';
import 'package:pets_app/ui/screens/Pets/Add%20Pet/view/add_pet_view.dart';
import 'package:pets_app/ui/screens/Profile/Profile%20Details/view/profile_details_view.dart';
import 'package:pets_app/ui/screens/home/view/home_view.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/drawer_configuration.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthProvider>(context);
    return Material(
      child: Container(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 24.0,
              horizontal: 20.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: drawerItems
                      .map(
                        (element) => InkWell(
                          onTap: () {
                            selectedItem(context, element['index']);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 24.0),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  element['icon'],
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 16.0,
                                ),
                                Text(
                                  element['title'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                Row(
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
              ],
            ),
          ),
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color.fromRGBO(70, 112, 112, 1.0),
              Color.fromRGBO(48, 96, 96, 1.0)
            ])),
      ),
    );
  }
}

void selectedItem(BuildContext context, int index) {
  switch (index) {
    case 0:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Wrapper(),
      ));
      break;
    case 2:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AddPetView(),
      ));
      break;
    case 4:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ProfileView(),
      ));
      break;
  }
}
