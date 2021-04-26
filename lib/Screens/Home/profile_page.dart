import 'package:clima_app/HelpingWidgets/auth_helpers.dart';
import 'package:clima_app/Services/auth.dart';
import 'package:clima_app/Services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Color(0xFF229062),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          padding: EdgeInsets.all(10),
          child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Users")
                  .doc(Provider.of<Authentication>(context, listen: false).getUserUid)
                  .snapshots(),
              builder: (context, snapshot) {
                print(Provider.of<DatabaseMethods>(context, listen: false).getInitUserName);
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      CircleAvatar(
                        radius: 70,
                        child:  Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(70),
                            child: Image.network("https://firebasestorage.googleapis.com/v0/b/clima-app-723ef.appspot.com/o/johnny.jpg?alt=media&token=d5b9e202-9d66-4fc9-93db-a8dea8587654",
                              fit: BoxFit.fill,),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Provider.of<AuthHelpers>(context, listen: false)
                          .showUserData(context, snapshot),
                      SizedBox(height: 40),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF229062),
                          padding: EdgeInsets.symmetric(
                            horizontal: 110,
                            vertical: 15,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          "Sign Out",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          Provider.of<Authentication>(context, listen: false)
                              .signOut()
                              .whenComplete(() {
                            Navigator.of(context).pushReplacementNamed(
                                "start");
                          });
                        },
                      ),
                    ],
                  );
                }
              }),
        ),
      ),
    );
  }
}
