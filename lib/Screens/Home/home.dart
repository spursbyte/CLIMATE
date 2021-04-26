import 'package:clima_app/Constants/yt_video_constant.dart';
import 'package:clima_app/HelpingWidgets/drawer_helpers.dart';
import 'package:clima_app/HelpingWidgets/video_helpers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Services/database.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  List<Map<String, String>> youtubeData = youtubeVideoData;

  checkAuthentication() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.pushReplacementNamed(context, "start");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    Provider.of<DatabaseMethods>(context, listen: false).initUserData(context);
    this.checkAuthentication();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Color(0xFF229062),
        centerTitle: true,
        elevation: 0.0,
      ),
      drawer: Provider.of<DrawerHelpers>(context, listen: false)
          .showDrawer(context),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Expanded(child: Container(
            child: ListView.builder(
              itemCount: youtubeData.length,
                itemBuilder: (context, index) {
              return YoutubeVideoTile(
                  imgUrl: youtubeData[index]["imgUrl"],
                  title: youtubeData[index]["title"],
                  postUrl: youtubeData[index]["postUrl"],
                  channelName: youtubeData[index]["channelName"],
                  logoUrl: youtubeData[index]["logoUrl"]);
            }),
          )),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
