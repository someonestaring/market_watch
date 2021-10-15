import 'package:market_watch/screens/!auth/authority.dart';
import 'package:market_watch/screens/auth/utility.dart';
import 'package:market_watch/state/app_state.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _dB = FirebaseFirestore.instance;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  User? user;
  bool authed = false;

  void _userSignIn() async {
    setState(() {
      user = _auth.currentUser;
    });
    var checker = user;
    if (checker != null) {
      String? _token = await _messaging.getToken();
      await _dB.collection('users').doc(checker.uid).get().then((res) {
        Map<String, dynamic>? data = res.data();
        if (data!.containsKey('tokens')) {
          List tokens = data['tokens'];
          if (tokens.contains(_token)) {
            AppStateWidget.of(context).updateUserData({
              'email': data['email'],
              'profilePhoto': data['profilePhoto'],
              'fullName': data['fullName'],
              'firstName': data['firstName'],
              'lastName': data['lastName'],
              "lastActive": DateTime.now(),
              'username': data['username'],
            });
            res.reference.update({
              'lastActive': DateTime.now(),
            });
            return;
          } else {
            res.reference.update({
              'lastActive': DateTime.now(),
              'tokens': FieldValue.arrayUnion([_token]),
            });
          }
        } else {
          res.reference.update({
            'lastActive': DateTime.now(),
            'tokens': [_token]
          });
        }
        AppStateWidget.of(context).updateUserData({
          'email': data['email'],
          'profilePhoto': data['profilePhoto'],
          'fullName': data['fullName'],
          'firstName': data['firstName'],
          'lastName': data['lastName'],
          "lastActive": DateTime.now(),
          'username': data['username'],
        });
      });
      setState(() {
        user != null ? authed = true : authed = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _userSignIn();
    _timer();
  }

  _timer() async {
    var _duration = const Duration(seconds: 5);
    return Timer(_duration, autoNav);
  }

  Future<void> autoNav() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => userAuthState(),
      ),
    );
  }

  Widget userAuthState() {
    if (!authed) {
      return const Authority();
    } else {
      return const Utility();
    }
  }

  @override
  Widget build(BuildContext context) {
    return splish(context);
  }
}

Widget splish(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return Scaffold(
      backgroundColor: Colors.black45,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(
              flex: 3,
            ),
            CircleAvatar(
              radius: size.width * 0.33,
              backgroundImage: const AssetImage('assets/images/MW_Logo.png'),
            ),
            const Spacer(
              flex: 3,
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.085),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'From',
                    style: TextStyle(
                      fontSize: 32.0,
                      color: Colors.white54,
                    ),
                  ),
                  Text(
                    'CHIPPERTON',
                    style: TextStyle(
                      fontSize: 32.0,
                      color: Colors.white54,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ));
}
