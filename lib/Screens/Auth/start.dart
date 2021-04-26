import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  checkAuthentication() async {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        Navigator.pushReplacementNamed(context, "/" ); //correction
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentication();
  }


  navigateToLogin() async {
    Navigator.pushReplacementNamed(context, "signIn");
  }

  navigateToRegister() async {
    Navigator.pushReplacementNamed(context, "signUp");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(height: 150.0),
              CircleAvatar(
                radius: 70,
                child:  Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(70),
                    child: Image.network("https://firebasestorage.googleapis.com/v0/b/clima-app-723ef.appspot.com/o/WhatsApp%20Image%202021-04-26%20at%2006.31.17.jpeg?alt=media&token=db322abd-99f3-44dc-8443-a4920a829cd7",
                      fit: BoxFit.fill,),
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              Container(
                margin: EdgeInsets.fromLTRB(35.0, 0.0, 35.0, 0.0),
                child: RichText(
                  text: TextSpan(
                    text: 'Welcome to ', style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(40),
                child: Text('PARYAVARAN - Your Environment Buddy',
                  style: TextStyle(
                    color:  Color(0xFF229062),
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),),
              ),
              SizedBox(height: 30.0),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: navigateToLogin,
                    child: Text('LOGIN', style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      primary:  Color(0xFF229062),
                    ),
                  ),
                  SizedBox(width: 20.0),
                  ElevatedButton(
                    onPressed: navigateToRegister,
                    child: Text('REGISTER', style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      primary:  Color(0xFF229062),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
}


