import 'dart:async';

import 'package:flutter/material.dart';
import 'package:studentdemoapp/main/Routes.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashView(),
      onGenerateRoute: AppRoutes().getRoutes,
    );
  }
}

class SplashView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashState();

}

class SplashState extends State<SplashView> with SingleTickerProviderStateMixin {

  startTimeout() async {return Timer(const Duration(seconds: 1), navigateRoot);}

  void navigateRoot() async{
      Navigator.of(context).pushNamedAndRemoveUntil('/welcome', (Route<dynamic> route) => false);
  }

  @override
  void initState() {
    super.initState();
    startTimeout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/splash.png"), fit: BoxFit.cover),
        ),
      ),
    );
  }
}
