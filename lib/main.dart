import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:tutorial_firebase/services/authentication.dart';

import 'pages/home.dart';
import 'pages/login.dart';

final ThemeData kIOSTheme = ThemeData(
  primarySwatch: Colors.orange,
  primaryColor: Colors.grey[100],
  primaryColorBrightness: Brightness.light
);

final ThemeData kAndroidTheme = ThemeData(
  primarySwatch: Colors.purple,
  accentColor: Colors.orangeAccent[400]
);

void main() {
  runApp(ChatApp());
}

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class ChatApp extends StatefulWidget {

  final BaseAuth auth = new Auth();

  @override
  _ChatAppState createState() => _ChatAppState();
}

class _ChatAppState extends State<ChatApp> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userId = "";

  @override
  void initState() {
    super.initState();
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _userId = user?.uid;
        }
        authStatus = user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget currentContext;
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        currentContext = _buildWaitingScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
        currentContext = LoginPage(
          auth: widget.auth,
          onSignedIn: _onLoggedIn,
        );
        break;
      case AuthStatus.LOGGED_IN:
        if (_userId.length > 0 && _userId != null) {
          currentContext = ChatScreen(
            userId: _userId,
            auth: widget.auth,
            onSignedOut: _onSignedOut,
          );
        } else {
          currentContext = _buildWaitingScreen();
        }
        break;
      default:
        break;
    }
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat App',
        theme: defaultTargetPlatform == TargetPlatform.android ? kAndroidTheme : kIOSTheme,
        home: currentContext,
        routes: <String, WidgetBuilder> {
          '/login': (BuildContext context) => LoginPage(),
          '/home': (BuildContext context) => ChatScreen()
        },
    );
  }

    void _onLoggedIn() {
    widget.auth.getCurrentUser().then((user){
      setState(() {
        _userId = user.uid.toString();
      });
    });
    setState(() {
      authStatus = AuthStatus.LOGGED_IN;

    });
  }

  void _onSignedOut() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userId = "";
    });
  }

  Widget _buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }
}

