import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:xen_shop/bloc/product_details/product_details.dart';
import 'package:xen_shop/bloc/product_details/product_details_bloc.dart';
import 'package:xen_shop/bloc/product_details/product_details_state.dart';
import 'package:xen_shop/components/styles/strings.dart';
import 'package:xen_shop/components/util/app_constants.dart';
import 'package:xen_shop/components/widgets/image_loader.dart';
import 'package:xen_shop/components/widgets/product_item.dart';
import 'package:xen_shop/models/cart/cart_model.dart';
import 'package:xen_shop/models/product/product_model.dart';
import 'package:xen_shop/repository/product_repository/product_repository.dart';

class CartItem extends StatefulWidget {
  final Products product;

  CartItem({Key key, this.product}) : super(key: key);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  ProductDetailsBloc productDetailsBloc;
  List<String> quantitySelection = ["1", "2", "3", "4", "5", "6", "7", "8"];

  @override
  void initState() {
    productDetailsBloc = BlocProvider.of<ProductDetailsBloc>(context);
    productDetailsBloc.add(GetProductDetails(id: widget.product.productId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
      key: widget.key,
      builder: (context, state) {
        if (state is ProductDetailsInitial) {
          return Container();
        } else if (state is ProductDetailsLoading) {
          return Center(
            child: Container(
              height: 110,
              alignment: Alignment.center,
              child: SizedBox(
                  height: 25, width: 25, child: CircularProgressIndicator()),
            ),
          );
        } else if (state is ProductDetailsLoaded) {
          return Stack(
            children: [
              ProductItem(
                product: state.product,
                isFromCart: true,
              ),
              Positioned(
                bottom: 0,
                right: 10,
                child: Row(
                  children: [
                    Text(
                      Strings.qty,
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    DropdownButton<String>(
                      underline: SizedBox(),
                      value: widget.product.quantity.toString(),
                      icon: Icon(Icons.keyboard_arrow_down),
                      hint: Text(widget.product.quantity.toString()),
                      items: quantitySelection
                          .map((value) => DropdownMenuItem<String>(
                              value: value, child: Text(value)))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          widget.product.quantity = int.parse(val);

                        });
                      },
                    ),
                  ],
                ),
              )
            ],
          );
        } else if (state is ProductDetailsError) {
          return Text(state.message);
        } else {
          return Container();
        }
      },
    );
  }
}
