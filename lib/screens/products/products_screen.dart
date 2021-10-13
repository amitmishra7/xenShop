import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xen_shop/bloc/category/category_bloc.dart';
import 'package:xen_shop/bloc/category/category_event.dart';
import 'package:xen_shop/bloc/category/category_state.dart';
import 'package:xen_shop/bloc/products/product_bloc.dart';
import 'package:xen_shop/bloc/products/product_event.dart';
import 'package:xen_shop/bloc/products/product_state.dart';
import 'package:xen_shop/components/styles/strings.dart';
import 'package:xen_shop/components/util/app_constants.dart';
import 'package:xen_shop/components/widgets/image_loader.dart';
import 'package:xen_shop/models/category/category.dart';
import 'package:xen_shop/models/product/product.dart';

class ProductsScreen extends StatefulWidget {
  final String category;

  ProductsScreen(this.category);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  ProductBloc productBloc;

  @override
  void initState() {
    productBloc = BlocProvider.of<ProductBloc>(context);
    productBloc.add(GetProducts(category: widget.category));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.all(12),
      child: _buildProductList(),
    );
  }

  Widget _buildProductList() {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductsInitial) {
          return Container();
        } else if (state is ProductsLoading) {
          return Center(
            child: SizedBox(
                height: 25, width: 25, child: CircularProgressIndicator()),
          );
        } else if (state is ProductsLoaded) {
          return _buildProductListing(state.products);
        } else if (state is ProductsError) {
          return Text(state.message);
        } else {
          return Text(Strings.somethingWentWrong);
        }
      },
    );
  }

  Widget _buildProductListing(List<Product> products) {
    return ListView.separated(
        separatorBuilder: (context, index) => SizedBox(
              width: 10,
            ),
        padding: const EdgeInsets.all(8),
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildProductItem(products[index]);
        });
  }

  Widget _buildProductItem(Product product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(product.title),
      ],
    );
  }
}
