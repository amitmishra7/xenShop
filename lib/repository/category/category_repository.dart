import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:xen_shop/components/api/api.dart';
import 'package:xen_shop/components/api/remote_data_source.dart';
import 'package:xen_shop/models/category/category.dart';

class CategoryRepository {
  RemoteDateSource remoteDateSource = RemoteDateSource();

  Future<Category> fetchCategories(String categoryName) {
    return Future.delayed(
      Duration(seconds: 1),
      () {
        return Category(
          categoryName: categoryName,
        );
      },
    );
  }

  Future<List<Category>> fetchCategoryList() async {
    try {
      Response response = await remoteDateSource.getCategoryListing();
      return response.data
          .map<Category>((json) => Category(categoryName: json))
          .toList();
    } catch (err) {
      throw NetworkError();
    }
  }
}

class NetworkError extends Error {

}
