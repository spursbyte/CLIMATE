import '../../Services/auth.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool showPassword;
  String _email, _password;

  @override
  void initState() {
    super.initState();
    showPassword = true;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFF229062),
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          padding: EdgeInsets.all(10),
          color:  Color(0xFF229062),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: size.height * 0.05,
              ),
              RichText(
                text: TextSpan(
                    text: "Sign In",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color:  Color(0xFFAAC6A4),)),
              ),
              SizedBox(height: 20,),
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
              SizedBox(height: 30),
              Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: TextFormField(
                            style: TextStyle(
                              color: Color(0xFFD9FFF5),
                            ),
                            cursorColor: Color(0xFFD9FFF5),
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Color(0xFF51291E),
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Color(0xFFD9FFF5),
                                    )),
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                  color: Color(0xFFAAC6A4),
                                ),
                                prefixIcon: Icon(Icons.email_outlined, color: Color(0xFF51291E),)),
                            validator: (input) {
                              return input.isEmpty ? "Enter Email" : null;
                            },
                            onSaved: (input) => _email = input),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: TextFormField(
                            style: TextStyle(
                              color: Color(0xFFD9FFF5),
                            ),
                            cursorColor: Color(0xFFD9FFF5),
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Color(0xFF51291E),
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Color(0xFFD9FFF5),
                                    )),
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                  color: Color(0xFFAAC6A4),
                                ),
                                prefixIcon: Icon(Icons.lock_outline_sharp, color: Color(0xFF51291E),),
                                suffix: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showPassword = !showPassword;
                                    });
                                  },
                                  child: showPassword
                                      ? Icon(Icons.visibility, color: Color(0xFF51291E),)
                                      : Icon(Icons.visibility_off , color: Color(0xFF51291E),),
                                )),
                            obscureText: showPassword,
                            validator: (input) {
                              return input.isEmpty ? "Enter Password" : null;
                            },
                            onSaved: (input) => _password = input),
                      ),
                      SizedBox(height: size.height * 0.1),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            Provider.of<Authentication>(context,
                                listen: false)
                                .logIntoAccount(context, _email, _password)
                                .whenComplete(() =>
                                Navigator.pushReplacementNamed(
                                    context, "/"));
                          }
                        },
                        child: Text('Log in',
                            style: TextStyle(
                                color: Color(0xFFAAC6A4),
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 110, vertical: 15),
                          primary: Color(0xFF0c7054),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an Account?",
                    style: TextStyle(
                      color: Color(0xFFAAC6A4),
                    ),
                  ),
                  SizedBox(width: 5,),
                  GestureDetector(
                    child: Text("Create one",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Color(0xFF51291E),
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, "signUp");
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    primary: Colors.lightBlue,
                    padding: EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                  ),
                  child: Text(
                    "Sign In With Google",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Provider.of<Authentication>(context, listen: false).signInWithGoogle(context);
                  }),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
