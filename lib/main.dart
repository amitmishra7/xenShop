import 'package:flutter/material.dart';
import 'package:xen_shop/components/styles/colors_theme.dart';
import 'package:xen_shop/components/styles/strings.dart';
import 'components/routes/route_paths.dart';
import 'components/routes/router.dart' as AppRouter;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: Strings.appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: RoutePaths.Splash,
        onGenerateRoute: AppRouter.Router.generateRoute);
  }
}
