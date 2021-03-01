import 'package:flutter/material.dart';
import 'package:studentdemoapp/main/Routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  static final MyApp _instance = MyApp._internal();
  MyApp._internal();
  factory MyApp() => _instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Montserrat',
        //brightness: Brightness.light,
        //primaryColor: Colors.blue[600],
        //accentColor: Colors.black,
        //primaryTextTheme: TextTheme(title: TextStyle(color: Colors.black))
      ),
      onGenerateRoute: getAppRoutes().getRoutes,
    );
  }

  AppRoutes getAppRoutes(){
    return AppRoutes();
  }
}
