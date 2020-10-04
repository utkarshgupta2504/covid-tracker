import 'package:covid_tracker/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:covid_tracker/Config/flutter_toast.dart';

import 'main_stats_page.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String email, password;
  bool showSpinner = false;

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF212B46),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: Column(
//            crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: Image.asset(
                    'images/virus.png',
                    height: 120.0,
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Enter Email'),
                  onChanged: (change) => {email = change},
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  obscureText: true,
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Enter Password'),
                  onChanged: (change) => {password = change},
                ),
                SizedBox(
                  height: 50.0,
                ),
                FloatingActionButton.extended(
                  heroTag: 'Register',
                  backgroundColor: Color(0xFFEA5569),
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final newUser = await _auth.createUserWithEmailAndPassword(
                          email: email, password: password);

                      if (newUser != null) {
                        print('User Created');
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => MainStatsPage()));
                      }

                      setState(() {
                        showSpinner = false;
                      });
                    } catch (e) {
                      showLongToast('Cannot sign up user\nReason: ' + e.toString());
                      setState(() {
                        showSpinner = false;
                      });
                    }
                  },
                  label: Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
