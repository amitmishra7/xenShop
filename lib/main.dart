import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xen_shop/bloc/cart/cart_bloc.dart';
import 'package:xen_shop/bloc/category/category_bloc.dart';
import 'package:xen_shop/bloc/product_details/product_details_bloc.dart';
import 'package:xen_shop/bloc/products/product_bloc.dart';
import 'package:xen_shop/components/styles/strings.dart';
import 'package:xen_shop/repository/cart_repository/cart_repository.dart';
import 'package:xen_shop/repository/category_repository/category_repository.dart';
import 'package:xen_shop/repository/product_repository/product_repository.dart';

import 'components/routes/route_paths.dart';
import 'components/routes/router.dart' as AppRouter;

void main() {
  ProductRepository productRepository = ProductRepository();
  runApp(MultiBlocProvider(providers: [
    BlocProvider<CategoryBloc>(
      create: (context) => CategoryBloc(CategoryRepository()),
    ),
    BlocProvider<ProductBloc>(
      create: (context) => ProductBloc(productRepository),
    ),
    BlocProvider<CartBloc>(
      create: (context) => CartBloc(CartRepository()),
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
