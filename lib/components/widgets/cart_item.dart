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
          return ProductItem(
            product: state.product,
            isFromCart: true,
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

