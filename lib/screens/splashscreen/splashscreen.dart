import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xen_shop/components/routes/route_paths.dart';
import 'package:xen_shop/components/util/app_constants.dart';
import 'package:xen_shop/components/widgets/image_loader.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(
          context, RoutePaths.Home, ModalRoute.withName(RoutePaths.Home));
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
          body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 300,
                child: ImageLoader.withImage(
                    imageUrl: 'assets/xendit_logo.jpg',
                    imageType: ImageType.ASSET,
                    showCircleImage: false,
                    roundCorners: false),
              )
            ],
          ),
        ),
      )),
    );
  }
}
