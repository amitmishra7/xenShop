import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xen_shop/bloc/category/category_bloc.dart';
import 'package:xen_shop/bloc/category/category_event.dart';
import 'package:xen_shop/bloc/category/category_state.dart';
import 'package:xen_shop/components/routes/route_paths.dart';
import 'package:xen_shop/components/styles/strings.dart';
import 'package:xen_shop/components/util/app_constants.dart';
import 'package:xen_shop/components/widgets/image_loader.dart';
import 'package:xen_shop/models/category/category.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CategoryBloc categoryBloc;

  @override
  void initState() {
    categoryBloc = BlocProvider.of<CategoryBloc>(context);
    categoryBloc.add(GetCategory());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.appName),
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(

        onPressed: () {
          Navigator.pushNamed(context, RoutePaths.Cart);
        },
        child: Icon(Icons.shopping_cart,color: Colors.white,),
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.all(12),
      child: _buildCategoryList(),
    );
  }

  Widget _buildCategoryList() {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryInitial) {
          return Container();
        } else if (state is CategoryLoading) {
          return Center(
            child: SizedBox(
                height: 25, width: 25, child: CircularProgressIndicator()),
          );
        } else if (state is CategoryLoaded) {
          return Column(
            children: [
              Container(
                height: 125,
                child: _buildCategoryThumbnail(state.categories),
              ),
              _buildCategoryBanner(state.categories),
            ],
          );
        } else if (state is CategoryError) {
          return Text(Strings.networkError);
        } else {
          return Text(Strings.somethingWentWrong);
        }
      },
    );
  }

  Widget _buildCategoryBanner(List<Category> categories) {
    return Expanded(
      child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(
                height: 15,
              ),
          padding: const EdgeInsets.all(8),
          itemCount: categories.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildCategoryBannerItem(
                categoryName: categories[index].categoryName,
                imageUrl: categories[index]
                    .categoryName
                    .replaceAll("'s clothing", ""));
          }),
    );
    ;
  }

  Widget _buildCategoryThumbnail(List<Category> categories) {
    return ListView.separated(
        separatorBuilder: (context, index) => SizedBox(
              width: 10,
            ),
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(8),
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildCategoryThumbnailItem(
              categoryName: categories[index].categoryName,
              imageUrl:
                  categories[index].categoryName.replaceAll("'s clothing", ""));
        });
  }

  Widget _buildCategoryThumbnailItem({String categoryName, String imageUrl}) {
    var imgUrl = 'assets/$imageUrl.jpg';
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, RoutePaths.Products, arguments: categoryName);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            child: ImageLoader.withImage(
                imageUrl: imgUrl,
                imageType: ImageType.ASSET,
                showCircleImage: false,
                roundCorners: false),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryBannerItem({String categoryName, String imageUrl}) {
    var imgUrl = 'assets/${imageUrl}_banner.jpg';
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RoutePaths.Products, arguments: categoryName);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            categoryName.toUpperCase(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: Container(
              height: 225,
              width: double.infinity,
              child: ImageLoader.withImage(
                  boxFit: BoxFit.cover,
                  imageUrl: imgUrl,
                  imageType: ImageType.ASSET,
                  showCircleImage: false,
                  roundCorners: false),
            ),
          ),
        ],
      ),
    );
  }
}
