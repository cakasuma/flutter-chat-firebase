import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login to Chat App'),
      ),
      body: Container(
        margin: EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            RaisedButton(
              child: Text('Login'),
              onPressed: () {
                Navigator.of(context).pushNamed('/home');
              },
              color: Colors.blue,
            ),
            RaisedButton(
              child: Text('Signup'),
              onPressed: () {
                Navigator.of(context).pushNamed('/signup');
              },
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}