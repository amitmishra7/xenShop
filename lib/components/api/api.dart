import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:xen_shop/components/styles/strings.dart';
import 'package:xen_shop/components/util/app_constants.dart';
import 'package:xen_shop/models/error/error_model.dart';

///API class responsible for calling http api.
class ApiRequest {
  Dio dio = Dio();

  ApiRequest() {
    dio.options.connectTimeout = AppConstants.connectionTimeout;
    dio.options.receiveTimeout = AppConstants.receiveTimeout;
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  Future<Response> post({
    String endPoint,
    Map<String, dynamic> data,
    listData,
    Map<String, dynamic> headers,
  }) async {
    dio.options.baseUrl = AppConstants.baseUrl;
    if (headers != null) {
      dio.options.headers = headers;
    }
    try {
      Response response =
          await dio.post(endPoint, data: data != null ? data : listData);
      return Future.value(response);
    } on DioError catch (e) {
      if (e.response == null) {
        return Future.error(jsonEncode(
            ErrorModel(code: "101", message: parseErrorResponse(e)).toJson()));
      } else {
        return Future.error(e.response);
      }
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  Future<Response> put(
      {String endPoint,
      Map<String, dynamic> data,
      FormData formData,
      Map<String, dynamic> headers,
      bool isCareTeam = false}) async {
    dio.options.baseUrl = AppConstants.baseUrl;
    if (headers != null) {
      dio.options.headers = headers;
    }
    try {
      Response response =
          await dio.put(endPoint, data: formData != null ? formData : data);
      return Future.value(response);
    } on DioError catch (e) {
      if (e.response == null) {
        return Future.error(jsonEncode(
            ErrorModel(code: "101", message: parseErrorResponse(e)).toJson()));
      } else {
        return Future.error(e.response);
      }
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  Future<Response> get({String endPoint, Map<String, dynamic> headers}) async {
    dio.options.baseUrl = AppConstants.baseUrl;

    if (headers != null) {
      dio.options.headers = headers;
    }
    try {
      Response response = await dio.get(endPoint);
      return Future.value(response);
    } on DioError catch (e) {
      if (e.response == null) {
        return Future.error(jsonEncode(
            ErrorModel(code: "101", message: parseErrorResponse(e)).toJson()));
      } else {
        return Future.error(e.response);
      }
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  ///Function responsible for error parsing
  String parseErrorResponse(Exception exception) {
    String errorMessage;
    if (exception is DioError) {
      print("Exception: ${exception.type}");
      switch (exception.type) {
        case DioErrorType.cancel:
          errorMessage = Strings.cancelError;
          break;
        case DioErrorType.connectTimeout:
          errorMessage = Strings.connectionTimeout;
          break;
        case DioErrorType.receiveTimeout:
          errorMessage = Strings.timeoutError;
          break;
        case DioErrorType.other:
          errorMessage = Strings.networkError;
          break;
        case DioErrorType.response:
          errorMessage = Strings.badGateWayError;
          break;
        case DioErrorType.sendTimeout:
          errorMessage = Strings.timeoutError;
          break;
      }
      return errorMessage;
    } else {
      return Strings.unexpectedError;
    }
  }
}
