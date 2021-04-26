import 'package:clima_app/Screens/Complaint/complaint_home.dart';
import 'package:flutter/material.dart';

class ComplaintSuccessful extends StatefulWidget {
  @override
  _ComplaintSuccessfulState createState() => _ComplaintSuccessfulState();
}

class _ComplaintSuccessfulState extends State<ComplaintSuccessful> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complaint Successful"),
        backgroundColor: Color(0xFF229062),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: ElevatedButton(
            child: Text(
              'Go Back',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                  horizontal: 50, vertical: 15),
              primary:  Color(0xFF229062),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            onPressed: () {
             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ComplaintHome()));
            },
          ),
        ),
      ),
    );
  }
}
