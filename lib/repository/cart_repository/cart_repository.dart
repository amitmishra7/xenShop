
import 'package:dio/dio.dart';
import 'package:xen_shop/components/api/remote_data_source.dart';
import 'package:xen_shop/models/cart/cart_model.dart';
import 'package:xen_shop/models/error/error_model.dart';
import 'package:xen_shop/repository/base_repository/base_repository.dart';

class CartRepository extends BaseRepository {
  RemoteDateSource remoteDateSource = RemoteDateSource();

  Future<List<CartModel>> fetchCart() async {
    try {
      Response response = await remoteDateSource.getCart();
      return response.data
          .map<CartModel>((json) => CartModel.fromJson(json))
          .toList();
    } catch (err) {
      throw NetworkError(err);
    }
  }
}
