import 'package:covid_tracker/Screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Future<void> sleepApp() async {
    await Future.delayed(Duration(seconds: 2));
    await Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fitHeight,
            image: AssetImage(
              'images/background.jpg',
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            FloatingActionButton.extended(
              heroTag: 'Register',
              backgroundColor: Color(0xFFEA5569),
              onPressed: () => {
                Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()))
              },
              label: Text('Register'),
            ),
            SizedBox(
              height: 30.0,
            ),
            FloatingActionButton.extended(
              heroTag: 'Login',
              backgroundColor: Color(0xFFEA5569),
              onPressed: () =>
                  {Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()))},
              label: Text('Login'),
            ),
            SizedBox(
              height: 100.0,
            )
          ],
        ),
      ),
    );
  }
}
