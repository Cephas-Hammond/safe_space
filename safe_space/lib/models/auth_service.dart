import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:safe_space/screens/home.dart';

import 'package:safe_space/screens/signup.dart';

class AuthService {
  //Handle Authentication
  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return Homepage();
          } else {
            return SignUp();
          }
        });
  }

  //SignOut
  signOut() {
    FirebaseAuth.instance.signOut();
  }

  //SignIn
  signIn(AuthCredential authCreds) {
    FirebaseAuth.instance.signInWithCredential(authCreds);
  }

  signInWithOTP(smsCode, verId) {
    AuthCredential authCreds =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
    signIn(authCreds);
  }
}
