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
}
