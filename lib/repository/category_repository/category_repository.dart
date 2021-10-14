
import 'package:dio/dio.dart';
import 'package:xen_shop/components/api/remote_data_source.dart';
import 'package:xen_shop/models/category/category.dart';
import 'package:xen_shop/models/error/error_model.dart';
import 'package:xen_shop/repository/base_repository/base_repository.dart';

class CategoryRepository extends BaseRepository {
  RemoteDateSource remoteDateSource = RemoteDateSource();

  Future<List<Category>> fetchCategoryList() async {
    try {
      Response response = await remoteDateSource.getCategoryListing();
      return response.data
          .map<Category>((json) => Category(categoryName: json))
          .toList();
    } catch (err) {
      throw NetworkError(err);
    }
  }
}
