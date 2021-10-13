import 'package:dio/dio.dart';
import 'package:xen_shop/components/api/api.dart';

class RemoteDateSource {
  ApiRequest apiRequest = ApiRequest();

  ///Get categories list
  Future<Response> getCategoryListing() async {
    try {
      Response response = await apiRequest.get(endPoint: "products/categories");
      print("Dio response-- ${response.data}");
      return Future.value(response);
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  ///Get products list
  Future<Response> getProducts(String category) async {
    try {
      Response response = await apiRequest.get(endPoint: "products/category/$category");
      print("Dio response-- ${response.data}");
      return Future.value(response);
    } catch (err) {
      return Future.error(err.toString());
    }
  }


  ///Get cart list
  Future<Response> getCart() async {
    try {
      Response response = await apiRequest.get(endPoint: "carts/1");
      print("Dio response-- ${response.data}");
      return Future.value(response);
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  ///Get product details
  Future<Response> getProductDetails(int id) async {
    try {
      Response response = await apiRequest.get(endPoint: "products/$id");
      print("Dio response-- ${response.data}");
      return Future.value(response);
    } catch (err) {
      return Future.error(err.toString());
    }
  }
}
