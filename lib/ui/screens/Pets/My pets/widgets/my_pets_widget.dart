import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pets_app/core/constants/drawer_configuration.dart';
import 'package:pets_app/ui/screens/menu/widgets/menu_icon_widget.dart';
import 'package:pets_app/ui/ui_utils/config_setup/size_config.dart';

class MyPetsWidget extends StatefulWidget {
  const MyPetsWidget({Key? key}) : super(key: key);

  @override
  _MyPetsWidgetState createState() => _MyPetsWidgetState();
}

class _MyPetsWidgetState extends State<MyPetsWidget> {
  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final deviceWidth = MediaQuery.of(context).size.width;
    final sizeConfig = SizeConfig();
    sizeConfig.init(context);
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .collection('pets_list')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: primaryGreen,
            body: Center(
              child: SpinKitFadingCube(
                color: Colors.white,
                size: 80.0,
              ),
            ),
          );
        }
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: sizeConfig.getProportionateScreenHeight(50),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      MenuIconWidget(),
                      Column(
                        children: [
                          Text('Address'),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: primaryGreen,
                              ),
                              Text('Tunisia'),
                            ],
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: 24.0,
                        backgroundImage:
                            AssetImage('assets/images/adopt_me_logo.png'),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.search),
                      Text('Search pet'),
                      Icon(Icons.settings)
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: snapshot.data!.docs.map((document) {
                      return GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: 10.0,
                            right: 20.0,
                            left: 20.0,
                          ),
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: <Widget>[
                              Material(
                                borderRadius: BorderRadius.circular(20.0),
                                elevation: 4.0,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20.0,
                                    vertical: 20.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      SizedBox(
                                        width: deviceWidth * 0.4,
                                      ),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              mainAxisSize: MainAxisSize.max,
                                              children: <Widget>[
                                                Text(
                                                  document['name'],
                                                  style: TextStyle(
                                                    fontSize: 26.0,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Icon(
                                                  document['gender']
                                                              .toString() ==
                                                          'Female'
                                                      ? FontAwesomeIcons.venus
                                                      : FontAwesomeIcons.mars,
                                                  color: Colors.grey,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Text(
                                              document['type'],
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Text(
                                              '${document['age']} years old',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Icon(
                                                  FontAwesomeIcons.calendar,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  size: 16.0,
                                                ),
                                                SizedBox(
                                                  width: 6.0,
                                                ),
                                                Text(
                                                  document['date'],
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Stack(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    height: 190.0,
                                    width: deviceWidth * 0.4,
                                  ),
                                  Hero(
                                    tag: document['name'],
                                    child: Image(
                                      image: NetworkImage(document['imageUrl']),
                                      height: 220.0,
                                      fit: BoxFit.fitHeight,
                                      width: deviceWidth * 0.4,
                                    ),
                                  ),
                                ],
                                alignment: Alignment.center,
                              )
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
