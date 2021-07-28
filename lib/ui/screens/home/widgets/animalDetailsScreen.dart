import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pets_app/core/constants/drawer_configuration.dart';
import 'package:pets_app/core/models/animal_model.dart';
import 'package:pets_app/core/models/user_model.dart';
import 'package:pets_app/core/services/user_service.dart';

class Screen2 extends StatefulWidget {
  final Animal animal;
  Screen2({required this.animal});

  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  bool onPressed = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    final currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    height: screenHeight * 0.5,
                    color: Color.fromRGBO(203, 213, 216, 1.0),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 60.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  FontAwesomeIcons.arrowLeft,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              Icon(FontAwesomeIcons.share,
                                  color: Theme.of(context).primaryColor),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: screenHeight * 0.35,
                    child: Hero(
                      tag: widget.animal.name,
                      child: Image(
                        image: NetworkImage(widget.animal.imageUrl),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 45,
              ),
              Expanded(
                  child: Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 22.0,
                    vertical: 30.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          CircleAvatar(
                            radius: 22.0,
                            backgroundImage:
                                AssetImage('assets/images/adopt_me_logo.png'),
                          ),
                          SizedBox(
                            width: 0.0,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'User User',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      widget.animal.date.toString(),
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  'Owner',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        widget.animal.description,
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
                color: Colors.white,
              )),
              Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Material(
                        borderRadius: BorderRadius.circular(20.0),
                        elevation: 4.0,
                        color: Theme.of(context).primaryColor,
                        child: Padding(
                          padding: EdgeInsets.all(7),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                onPressed = !onPressed;
                              });
                            },
                            icon: onPressed == false
                                ? Icon(
                                    FontAwesomeIcons.heart,
                                    color: Colors.white,
                                  )
                                : Icon(
                                    FontAwesomeIcons.solidHeart,
                                    color: Colors.white,
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 24.0,
                      ),
                      Expanded(
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          elevation: 4.0,
                          color: Theme.of(context).primaryColor,
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text(
                              'Contact',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                height: 100,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.06),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.0),
            child: Material(
              borderRadius: BorderRadius.circular(20.0),
              elevation: 6.0,
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(
                          widget.animal.name,
                          style: TextStyle(
                            fontSize: 26.0,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          widget.animal.gender == 'Female'
                              ? FontAwesomeIcons.venus
                              : FontAwesomeIcons.mars,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          widget.animal.type,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '${widget.animal.age} years old',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.mapMarkerAlt,
                          color: Theme.of(context).primaryColor,
                          size: 16.0,
                        ),
                        SizedBox(
                          width: 6.0,
                        ),
                        Text(
                          'Address',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                height: 140.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
