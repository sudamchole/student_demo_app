import 'package:flutter/material.dart';
import 'package:studentdemoapp/screens/register.dart';
import 'package:studentdemoapp/screens/splash.dart';
import 'package:studentdemoapp/screens/welcome.dart';

class AppRoutes{

  //--------------------------------------------------------------- Constants ------------------------------------------------------------------------
  static const String APP_ROUTE_REGISTER = "/register";
  static const String APP_ROUTE_WELCOME = "/welcome";


  //--------------------------------------------------------------- Methods --------------------------------------------------------------------------

  /// Get Routes Method -> Route
  /// @param -> routeSettings -> RouteSettings
  /// @usage -> Returns route based on requested route settings
  Route getRoutes(RouteSettings routeSettings){

    switch(routeSettings.name){

      case APP_ROUTE_WELCOME:{
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) => Welcome(),
          fullscreenDialog: true,
        );
      }

      case APP_ROUTE_REGISTER : {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) => Register(),
          fullscreenDialog: true,
        );
      }

      default: {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) => Splash(),
          fullscreenDialog: true,
        );
      }
    }
  }
}
