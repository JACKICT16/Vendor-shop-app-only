import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vendor_app_only/vendor/views/screens/tab_bar_screen/images_screen.dart';

class AccountScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    CollectionReference buyers =
        FirebaseFirestore.instance.collection('vendors');
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Profile',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 4,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.sunny_snowing,
                color: Colors.pink,
              ),
            )
          ],
        ),
        body: FutureBuilder<DocumentSnapshot>(
          future: buyers.doc(_auth.currentUser!.uid).get(),
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
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    CircleAvatar(
                      radius: 65,
                      backgroundImage: NetworkImage(data['storeImage']),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        data['shopName'].toUpperCase(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 5,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        data['emailAddress'],
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 200,
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.store),
                      title: Text(
                        "Status",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        data['status'].toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Divider(
                        thickness: 2,
                        color: Colors.grey,
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.settings,
                      ),
                      title: Text(
                        "Settings",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text(
                        "Phone",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        data['phoneNumber'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            return Center(
              child: ImagesScreen(),
            );
          },
        ));
  }
}
