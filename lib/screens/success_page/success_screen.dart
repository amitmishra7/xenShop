import 'dart:core';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:xen_shop/components/routes/route_paths.dart';
import 'package:xen_shop/components/styles/strings.dart';
import 'package:xen_shop/models/product/product_model.dart';

class SuccessScreen extends StatefulWidget {
  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: _buildSuccessScreen(),
      ),
    );
  }

  Widget _buildSuccessScreen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 75,
          height: 75,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.green,
          ),
          child: Icon(
            Icons.check,
            size: 50,
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          "Rs. 533",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          Strings.paymentSuccess,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
        ),
        SizedBox(
          height: 50,
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, RoutePaths.Home,
                    ModalRoute.withName(RoutePaths.Home));
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  padding: EdgeInsets.all(12),
                  textStyle:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              child: Text(
                Strings.continueShopping,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        )
      ],
    );
  }
}
