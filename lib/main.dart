import 'package:calculator/homepage.dart';
import 'package:calculator/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

Mytheme currentTheme = Mytheme();

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        themeMode: currentTheme.getThemeMode(),
        darkTheme: ThemeData(
            //primarySwatch: Colors.blue,
            primaryColor: Color(0xff22252D),
            accentColor: Color(0xff292D36),
            canvasColor: Color(0xffFCFCFC),
            cardColor: Color(0xff272B33)),
        theme: ThemeData(
            primaryColor: Colors.white,
            accentColor: Colors.grey[200],
            canvasColor: Color(0xff292D36),
            cardColor: Colors.grey[100]),
        home: Homepage());
  }
}
