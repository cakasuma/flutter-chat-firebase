import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';

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

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat App',
        theme: defaultTargetPlatform == TargetPlatform.android ? kAndroidTheme : kIOSTheme,
        home: LoginPage(),
        routes: <String, WidgetBuilder> {
          '/login': (BuildContext context) => ChatApp(),
          '/home': (BuildContext context) => ChatScreen()
        },
        );
  }
}

