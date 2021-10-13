import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:xen_shop/components/util/app_constants.dart';
import 'package:xen_shop/components/widgets/image_loader.dart';
import 'package:xen_shop/models/product/product_model.dart';

class ProductItem extends StatelessWidget {
  final ProductModel product;

  /// default value as false to hide increment decrement icons
  final bool isFromCart;

  ProductItem({this.product, this.isFromCart = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 110.0,
          child: ListTile(
            onTap: () {},
            leading: Container(
              height: 75,
              width: 75,
              child: ImageLoader.withImage(
                  imageUrl: product.image,
                  boxFit: BoxFit.fill,
                  imageType: ImageType.NETWORK,
                  showCircleImage: false,
                  roundCorners: false),
            ),
            title: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                product.title,
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.category,
                  style: TextStyle(fontSize: 14.0),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Rs." + product.price.toString(),
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    !isFromCart
                        ? RatingBar.builder(
                            initialRating: product.rating.rate,
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
                          )
                        : Container(),
                  ],
                ),
              ],
            ),
          ),
        ),
        Divider(
          height: 2.0,
          thickness: 2.0,
        ),
      ],
    );
  }
}
