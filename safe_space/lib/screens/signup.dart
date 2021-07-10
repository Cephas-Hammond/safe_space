import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class SignUp extends StatelessWidget {
  // Controllers for managing user signup
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  TextEditingController _username = new TextEditingController();

  final submitKey = GlobalKey<FormState>();

  String errormsg;

  //Manage user sign up with firebase authentication
  Future<void> signup(BuildContext context) async {
    try {
      // ignore: unused_local_variable
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );

      Navigator.of(context).pushReplacementNamed('\signin');
    } on FirebaseAuthException catch (e) {
      print(e);
      errormsg = e.message;
      Fluttertoast.showToast(
          msg: errormsg,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.redAccent,
          toastLength: Toast.LENGTH_SHORT);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.all(30),
          child: Form(
            key: submitKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 120,
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: "Enter Username:",
                        hintText: "Username",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                    controller: _username,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !value.contains('@')) {
                        return 'Please check your email again';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        labelText: "Enter Your Email:",
                        hintText: "Your Email",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                    controller: _email,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password can\'t be empty';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        labelText: "Enter Password:",
                        hintText: "Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                    controller: _password,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  width: 150,
                  child: TextButton(
                    child: Text("Sign Up"),
                    onPressed: () {
                      if (submitKey.currentState.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Processing Data'),
                                CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              ]),
                          backgroundColor: Theme.of(context).primaryColor,
                          duration: Duration(seconds: 1),
                        ));
                      }

                      signup(context);
                    },
                  ),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 219, 144, 1.0),
                      borderRadius: BorderRadius.circular(20)),
                ),
                Container(
                  margin: EdgeInsets.all(2),
                  width: 100,
                  child: TextButton(
                    child: Text(
                      "Sign In",
                      style: TextStyle(color: Colors.blue),
                    ),
                    // focusNode: Theme.of(context).accentColor,
                    // splashColor: Theme.of(context).accentColor,
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('signin');
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
