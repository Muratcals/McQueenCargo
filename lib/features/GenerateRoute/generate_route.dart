import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mc_queen_cargo/features/View/Splash/splash_screen_page.dart';

class GenerateRoute {
  Route<dynamic>? generate(RouteSettings settings) {
    switch (settings.name) {
      case "/": 
        route(page: SplashScreen());
    }
  }

  PageRoute route({required Widget page}) {
    if (Platform.isAndroid) {
      return MaterialPageRoute(
        builder: (context) => page,
      );
    } else {
      return CupertinoPageRoute(
        builder: (context) => page,
      );
    }
  }
}
