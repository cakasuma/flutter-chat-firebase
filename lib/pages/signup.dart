import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup to Chat App'),
      ),
      body: Container(
        margin: EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            RaisedButton(
              child: Text('back'),
              onPressed: () {
                Navigator.of(context).pushNamed('/login');
              },
              color: Colors.blue,
            ),
            RaisedButton(
              child: Text('go home'),
              onPressed: () {
                Navigator.of(context).pushNamed('/home');
              },
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}