import 'dart:convert';

import 'package:xen_shop/models/error/error_model.dart';

class BaseRepository {
  parseError(String error) {
    String errorMessage;
    try {
      ErrorModel errorModel = ErrorModel.fromJson(jsonDecode(error.toString()));
      errorMessage = errorModel.message;

      throw NetworkError(errorMessage);
    } catch (e) {
      errorMessage = error;
      throw NetworkError(errorMessage);
    }
  }
}
