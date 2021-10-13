import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:xen_shop/bloc/cart/cart_bloc.dart';
import 'package:xen_shop/bloc/cart/cart_event.dart';
import 'package:xen_shop/bloc/cart/cart_state.dart';
import 'package:xen_shop/bloc/category/category_bloc.dart';
import 'package:xen_shop/bloc/category/category_event.dart';
import 'package:xen_shop/bloc/category/category_state.dart';
import 'package:xen_shop/bloc/products/product_bloc.dart';
import 'package:xen_shop/bloc/products/product_event.dart';
import 'package:xen_shop/bloc/products/product_state.dart';
import 'package:xen_shop/components/styles/strings.dart';
import 'package:xen_shop/components/util/app_constants.dart';
import 'package:xen_shop/components/widgets/image_loader.dart';
import 'package:xen_shop/components/widgets/product_item.dart';
import 'package:xen_shop/models/cart/cart_model.dart';
import 'package:xen_shop/models/category/category.dart';
import 'package:xen_shop/models/product/product_model.dart';

class CartScreen extends StatefulWidget {

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartBloc cartBloc;

  @override
  void initState() {
    cartBloc = BlocProvider.of<CartBloc>(context);
    cartBloc.add(GetCart());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.cart),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.all(12),
      child: _buildCartList(),
    );
  }

  Widget _buildCartList() {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartInitial) {
          return Container();
        } else if (state is CartLoading) {
          return Center(
            child: SizedBox(
                height: 25, width: 25, child: CircularProgressIndicator()),
          );
        } else if (state is CartLoaded) {
          return _buildCartListing(state.cartList);
        } else if (state is CartError) {
          return Text(state.message);
        } else {
          return Text(Strings.somethingWentWrong);
        }
      },
    );
  }

  Widget _buildCartListing(List<CartModel> cartList) {
    return ListView.separated(
        separatorBuilder: (context, index) => SizedBox(
              width: 10,
            ),
        padding: const EdgeInsets.all(8),
        itemCount: cartList.length,
        itemBuilder: (BuildContext context, int index) {
          return Text('Cart Item : ${cartList[index].id}');
        });
  }
}
