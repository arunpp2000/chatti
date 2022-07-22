import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'Front.dart';

class Google extends StatefulWidget {
  const Google({Key? key}) : super(key: key);

  @override
  State<Google> createState() => _GoogleState();
}

class _GoogleState extends State<Google> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
          Center(
            child: InkWell(
              onTap:(){
                signInWithGoogle();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const NameList()));
              },
              child: const CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage("assets/g.png"),
              ),
            ),
          ),
        ],
      )
    );
  }
  signInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential userCredential =
    await FirebaseAuth.instance.signInWithCredential(credential);
    var userid = userCredential.user?.uid;
    var username = userCredential.user?.displayName;
    var userimage = userCredential.user?.photoURL;
    var useremail = userCredential.user?.email;

    FirebaseFirestore.instance.collection('user').doc(userid).set({
      "userid": userid,
      "username": username,
      "useremail": useremail,
      "userimage": userimage,
    });
  }
}
