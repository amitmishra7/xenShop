import 'dart:core';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:xen_shop/components/routes/route_paths.dart';
import 'package:xen_shop/components/styles/strings.dart';
import 'package:xen_shop/models/product/product_model.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel product;

  ProductDetailsScreen(this.product);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.productDetails),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.all(12),
      child: _buildProductDetails(),
    );
  }

  Widget _buildProductDetails() {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
                  child: Container(
                      height: 300.0,
                      width: MediaQuery.of(context).size.width,
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        shape: BoxShape.rectangle,
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: CachedNetworkImageProvider(widget.product.image)),
                      )),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 8.0, top: 8.0, right: 24.0, bottom: 8.0),
                  child: Container(
                    child: Text(
                      widget.product.title,
                      maxLines: 2,
                      style: TextStyle(
                          height: 1.4, fontWeight: FontWeight.w700, fontSize: 18.0),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 8.0, top: 8.0, right: 24.0, bottom: 8.0),
                  child: Container(
                    child: Text(
                      widget.product.description,
                      style: TextStyle(
                          height: 1.4, fontWeight: FontWeight.w400, fontSize: 16.0),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 8.0, top: 8.0, right: 24.0, bottom: 8.0),
                  child: Container(
                    child: Text(
                      widget.product.category.toUpperCase(),
                      maxLines: 2,
                      style: TextStyle(
                          height: 1.4, fontWeight: FontWeight.bold, fontSize: 14.0),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 8.0, top: 8.0, right: 24.0, bottom: 8.0),
                  child: Container(
                    child: RatingBar.builder(
                      initialRating:
                          double.parse(widget.product.rating.rate.toString()),
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      unratedColor: Colors.amber.withAlpha(50),
                      itemCount: 5,
                      itemSize: 20.0,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      updateOnDrag: true,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 8.0, top: 8.0, right: 24.0, bottom: 8.0),
                  child: Container(
                    child: Row(
                      children: [
                        Text(
                          Strings.rateCount,
                          maxLines: 2,
                          style: TextStyle(
                              height: 1.4,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0),
                        ),
                        Text(
                          '  ${widget.product.rating.count} ${Strings.people}',
                          maxLines: 2,
                          style: TextStyle(
                              height: 1.4,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0),
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
          Padding(
            padding:
            EdgeInsets.all(10),
            child: Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, RoutePaths.Cart);
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    padding: EdgeInsets.all(12),
                    textStyle:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                child: Text(
                  Strings.addToCart,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
