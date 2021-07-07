import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
                child: Column(
                  children: [
                    Card(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: Icon(Icons.person),
                              title: Text('Name'),
                              subtitle: Text(data['name']),
                            ),
                            SizedBox(height: 10),
                            ListTile(
                              leading: Icon(Icons.email),
                              title: Text('Email'),
                              subtitle: Text(data['email']),
                            ),
                            ListTile(
                              leading: Icon(Icons.phone),
                              title: Text('Phone Number'),
                              subtitle: Text(data['phoneNumber']),
                            ),
                            ListTile(
                              leading: Icon(Icons.location_city),
                              title: Text('Address'),
                              subtitle: Text(data['address']),
                            ),
                            SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ),
                    RaisedButton(
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
                  ],
                ),
              ),
            );
            ;
            //return Text("Full Name: ${data['name']} ${data['email']}");
          }

          return Text("loading");
        },
      ),
    );
  }
}
