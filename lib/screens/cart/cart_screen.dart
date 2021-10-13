import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xen_shop/bloc/cart/cart_bloc.dart';
import 'package:xen_shop/bloc/cart/cart_event.dart';
import 'package:xen_shop/bloc/cart/cart_state.dart';
import 'package:xen_shop/bloc/product_details/product_details_bloc.dart';
import 'package:xen_shop/components/styles/strings.dart';
import 'package:xen_shop/components/widgets/cart_item.dart';
import 'package:xen_shop/components/widgets/snack_bar_util.dart';
import 'package:xen_shop/models/cart/cart_model.dart';
import 'package:xen_shop/repository/cart_repository/cart_repository.dart';
import 'package:xen_shop/repository/product_repository/product_repository.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartBloc cartBloc;
  ProductRepository productRepository = ProductRepository();
  CartRepository cartRepository = CartRepository();

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
          return _buildCartListing(state.cart.products);
        } else if (state is CartError) {
          return Text(state.message);
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildCartListing(List<Products> productList) {
    if (productList.length > 0) {
      return Column(
        children: [
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                width: 10,
              ),
              padding: const EdgeInsets.all(8),
              itemCount: productList.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  confirmDismiss: (DismissDirection direction) async {
                    return await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(Strings.confirm),
                            content: Text(Strings.deleteAlert),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                                child: Text(Strings.cancel),
                              ),
                              TextButton(
                                  onPressed: () {
                                    /// currently only local remove item
                                    productList.removeAt(index);
                                    Navigator.of(context).pop(true);
                                  },
                                  child: Text(Strings.delete)),
                            ],
                          );
                        });
                  },
                  background: stackBehindDismiss(),
                  key: ObjectKey(productList[index].productId),
                  child: BlocProvider<ProductDetailsBloc>(
                    create: (context) => ProductDetailsBloc(productRepository),
                    child: CartItem(
                      key: ValueKey(productList[index].productId),
                      product: productList[index],
                    ),
                  ),
                );
              },
            ),
          ),
          _buildOrderButton(productList),
        ],
      );
    } else {
      Container(
        width: double.infinity,
        height: double.infinity,
        child: Text(Strings.cartEmpty),
      );
    }
  }

  Widget stackBehindDismiss() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.0),
      color: Colors.red,
      child: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }

  Widget _buildOrderButton(List<Products> productList) {
    bool isProgress = false;
    return isProgress
        ? Center(
            child: SizedBox(
                height: 25, width: 25, child: CircularProgressIndicator()),
          )
        : ElevatedButton(
            onPressed: () {
              isProgress = true;
              Map<String, dynamic> data = {
                "userId": 1,
                "date": "2020-10-13",
                "products": productList
              };
              cartRepository.addToCart(
                  data: data,
                  onSuccess: () {
                    isProgress = false;
                    SnackBarUtil.showToast(context, Strings.addedToCart);
                    Navigator.pop(context);
                  },
                  onError: () {
                    isProgress = false;
                    SnackBarUtil.showToast(context, Strings.somethingWentWrong);
                  });
            },
            style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 75, vertical: 15),
                textStyle:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            child: Text(
              Strings.placeOrder,
              style: TextStyle(color: Colors.white),
            ),
          );
  }
}
