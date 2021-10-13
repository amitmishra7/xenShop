import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xen_shop/components/routes/route_paths.dart';
import 'package:xen_shop/screens/home/home_screen.dart';
import 'package:xen_shop/screens/splashscreen/splashscreen.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.Splash:
        return CupertinoPageRoute(builder: (_) => SplashScreen());
      case RoutePaths.Home:
        return CupertinoPageRoute(builder: (_) => HomeScreen());
      default:
        {
          return CupertinoPageRoute(
              builder: (_) => Scaffold(
                    body: Center(
                      child: Text('No route defined for ${settings.name}'),
                    ),
                  ));
        }
    }
  }
}
