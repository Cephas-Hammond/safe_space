import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'signin.dart';

class SignUp extends StatelessWidget {
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  TextEditingController _username = new TextEditingController();

  Future<void> signup(BuildContext context) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );
    } catch (e) {
      print(e);
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Sign Up",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 30,
                  fontWeight: FontWeight.w200,
                ),
              ),
              SizedBox(
                height: 120,
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: "Enter Username:",
                      hintText: "Username"),
                  controller: _username,
                ),
                // decoration: BoxDecoration(
                //   color: Colors.lightBlue,
                //   borderRadius: BorderRadius.circular(10),
                // ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: InputDecoration(
                      icon: Icon(Icons.email),
                      labelText: "Enter Your Email:",
                      hintText: "Your Email"),
                  controller: _email,
                ),
                // decoration: BoxDecoration(
                //   color: Colors.lightBlue,
                //   borderRadius: BorderRadius.circular(10),
                // ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      labelText: "Enter Password:",
                      hintText: "Password"),
                  controller: _password,
                ),
                // decoration: BoxDecoration(
                //   color: Colors.lightBlue,
                //   borderRadius: BorderRadius.circular(10),
                // ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                width: 150,
                child: FlatButton(
                  child: Text("Sign Up"),
                  onPressed: () {
                    signup(context);
                  },
                ),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 219, 144, 1.0),
                    borderRadius: BorderRadius.circular(20)),
              ),
              Container(
                margin: EdgeInsets.all(10),
                width: 150,
                child: FlatButton(
                  child: Text("Sign In"),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => SignIn()));
                  },
                ),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 219, 144, 1.0),
                    borderRadius: BorderRadius.circular(20)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
