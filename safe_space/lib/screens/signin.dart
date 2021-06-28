import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
  //controllers for managing user credentials
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  FocusNode submitNode = FocusNode();

  //manage user signin using firebase authentication
  Future<void> signin(BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _email.text, password: _password.text);
    } catch (e) {
      print(e);
    }
    //If signin successful
    print("Sign In successful");
    Navigator.of(context).pushReplacementNamed('home');
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        //allows scrolling of page
        child: Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.all(30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
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
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (!value.contains('@') || value.isEmpty) {
                        return 'Please enter a correct email';
                      }
                      return null;
                    },
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
                        return 'Password required';
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
                  margin:
                      EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 2),
                  width: 150,
                  child: FlatButton(
                    focusNode: submitNode,
                    child: Text("Sign In"),
                    onPressed: () {
                      FocusScope.of(context).requestFocus(submitNode);
                      if (_formKey.currentState.validate()) {
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
                      signin(context);
                    },
                  ),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 219, 144, 1.0),
                      borderRadius: BorderRadius.circular(20)),
                ),
                Container(
                  margin: EdgeInsets.all(2),
                  width: 160,
                  child: FlatButton(
                    child: Text(
                      "create an account",
                      style: TextStyle(color: Colors.blue),
                    ),
                    focusColor: Theme.of(context).accentColor,
                    splashColor: Theme.of(context).accentColor,
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('signup');
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
