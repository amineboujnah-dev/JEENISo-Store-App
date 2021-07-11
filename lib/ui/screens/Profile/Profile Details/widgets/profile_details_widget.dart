import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pets_app/ui/screens/Profile/Edit%20Profile/view/edit_profile_view.dart';

class ProfileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    final currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
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
                  children: <Widget>[
                    Container(
                      height: 140,
                      width: 140,
                      margin: EdgeInsets.only(top: 30),
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 4, color: Theme.of(context).primaryColor),
                        shape: BoxShape.circle,
                        color: Colors.white,
                        image: DecorationImage(
                            image: NetworkImage(data['imageUrl'])),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      data['name'],
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      data['email'],
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
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
                      child: ElevatedButton(
                        style: TextButton.styleFrom(
                          primary: Colors.green,
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProfileView())),
                        child: Text(
                          "EDIT PROFILE",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 1,
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
                  ],
                ),
              ),
            );
          }
          return Scaffold();
        },
      ),
    );
  }
}
