import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:xen_shop/components/api/api.dart';
import 'package:xen_shop/components/api/remote_data_source.dart';
import 'package:xen_shop/models/category/category.dart';
import 'package:xen_shop/models/error/error_model.dart';
import 'package:xen_shop/models/product/product_model.dart';
import 'package:xen_shop/repository/base_repository/base_repository.dart';

class ProductRepository extends BaseRepository {
  RemoteDateSource remoteDateSource = RemoteDateSource();

  Future<List<ProductModel>> fetchProducts(String category) async {
    try {
      Response response = await remoteDateSource.getProducts(category);
      return response.data
          .map<ProductModel>((json) => ProductModel.fromJson(json))
          .toList();
    } catch (err) {
      throw NetworkError(err);
    }
  }

  Future<ProductModel> fetchProductDetails(int id) async {
    try {
      Response response = await remoteDateSource.getProductDetails(id);
      ProductModel product = ProductModel.fromJson(response.data);
      return product;
    } catch (err) {
      throw NetworkError(err);
    }
  }
}
