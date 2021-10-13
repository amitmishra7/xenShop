import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xen_shop/bloc/category/category_bloc.dart';
import 'package:xen_shop/components/styles/colors_theme.dart';
import 'package:xen_shop/components/styles/strings.dart';
import 'package:xen_shop/repository/category/category_repository.dart';
import 'components/routes/route_paths.dart';
import 'components/routes/router.dart' as AppRouter;

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider<CategoryBloc>(
      create: (context) => CategoryBloc(CategoryRepository()),
    ),
  ], child: MyApp()));
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
