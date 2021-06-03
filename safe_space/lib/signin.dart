import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safe_space/home.dart';

class SignIn extends StatelessWidget {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  Future<void> signin(BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _email.text, password: _password.text);
    } catch (e) {
      print(e);
    }
    print("Sign In successful");
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Homepage()));
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
                "Sign In",
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
                  child: Text("Sign In"),
                  onPressed: () {
                    signin(context);
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
