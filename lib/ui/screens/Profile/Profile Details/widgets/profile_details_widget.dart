import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pets_app/core/providers/google_sign_in_provider.dart';
import 'package:pets_app/core/services/authentication_service.dart';
import 'package:pets_app/ui/screens/Profile/Edit%20Profile/view/edit_profile_view.dart';
import 'package:provider/provider.dart';

class ProfileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    final currentUser = FirebaseAuth.instance.currentUser;
    final loginProvider = Provider.of<AuthService>(context);
    final loginWithGoogleprovider = Provider.of<GoogleSignProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
        actions: [
          IconButton(
            onPressed: () async {
              await loginProvider.logout();
              await loginWithGoogleprovider.logOut();
            },
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: users.doc(currentUser!.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Center(
              child: SingleChildScrollView(
                child: Card(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 100,
                        width: 100,
                        margin: EdgeInsets.only(top: 30),
                        child: Stack(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  AssetImage('assets/images/adopt_me_logo.png'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        data['name'].toString(),
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        data['email'].toString(),
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 40,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Theme.of(context).accentColor,
                        ),
                        child: RaisedButton(
                          color: Colors.green,
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditProfileView())),
                          child: Text(
                            "Edit Profile",
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2.2,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: Icon(Icons.person),
                              title: Text('Name'),
                              subtitle: Text(data['name'].toString()),
                            ),
                            SizedBox(height: 10),
                            ListTile(
                              leading: Icon(Icons.email),
                              title: Text('Email'),
                              subtitle: Text(data['email'].toString()),
                            ),
                            ListTile(
                              leading: Icon(Icons.phone),
                              title: Text('Phone Number'),
                              subtitle: Text(data['phoneNumber'].toString()),
                            ),
                            ListTile(
                              leading: Icon(Icons.location_city),
                              title: Text('Address'),
                              subtitle: Text(data['address'].toString()),
                            ),
                            SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );

            //return Text("Full Name: ${data['name']} ${data['email']}");
          }

          return Text("loading");
        },
      ),
    );
  }
}
