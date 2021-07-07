import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pets_app/core/constants/images_paths_constants.dart';
import 'package:pets_app/ui/screens/home/view/home_view.dart';
import 'package:pets_app/ui/ui_utils/config_setup/config.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 7), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => Wrapper()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final p = new SizeConfig();
    p.init(context);
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo here
            Image.asset(
              logoPath,
              height: p.getProportionateScreenHeight(300),
            ),
            SizedBox(
              height: p.getProportionateScreenHeight(20),
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black87),
            )
          ],
        ),
      ),
    );
  }
}
