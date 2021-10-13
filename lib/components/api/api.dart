import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart' as dio;
import 'package:http_parser/http_parser.dart';
import 'package:xen_shop/components/util/app_constants.dart';
import 'package:xen_shop/models/response/response.dart';

class API {
  final String baseUrl = AppConstants.baseUrl;

  Future<dynamic> get(String route, {var headers = const []}) async {
    final uri = baseUrl + route;

    print("Url: $uri");
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);

    HttpClientRequest request = await client.getUrl(Uri.parse(uri));
    request.headers.set('content-type', 'application/json');

    try {
      HttpClientResponse response = await request.close();
      String reply = await response.transform(utf8.decoder).join();
      return new Response(
          code: response.statusCode, response: jsonDecode(reply));
    } catch (error) {
      print("Error: $error");
      return new Response(code: 502, response: null);
    }
  }

  Future<dynamic> post(String route, var body,
      {var headers = const [], String contentType = "application/json"}) async {
    final uri = baseUrl + route;

    print(uri);
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);

    HttpClientRequest request = await client.postUrl(Uri.parse(uri));
    request.headers.set('content-type', contentType);

    request.add(utf8.encode(json.encode(body)));
    try {
      HttpClientResponse response = await request.close();
      String reply = await response.transform(utf8.decoder).join();
      return new Response(
          code: response.statusCode, response: jsonDecode(reply));
    } catch (error) {
      return new Response(code: 502, response: null);
    }
  }

  Future<dynamic> put(String route, var body,
      {var headers = const [],
      token = "",
      String contentType = "application/json",
      bool isCareteam = false}) async {
    final uri = baseUrl + route;

    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);

    HttpClientRequest request = await client.putUrl(Uri.parse(uri));
    request.headers.set('content-type', contentType);
    request.headers.set('Authorization', 'Bearer $token');
    print(uri);

    request.add(utf8.encode(json.encode(body)));

    try {
      HttpClientResponse response = await request.close();
      String reply = await response.transform(utf8.decoder).join();
      return new Response(
          code: response.statusCode, response: jsonDecode(reply));
    } catch (error) {
      return new Response(code: 502, response: null);
    }
  }

  Future<dynamic> delete(String route, var body,
      {var headers = const [],
      token = "",
      String contentType = "application/json"}) async {
    final uri = this.baseUrl + route;

    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);

    HttpClientRequest request = await client.deleteUrl(Uri.parse(uri));
    request.headers.set('content-type', contentType);
    request.headers.set('Authorization', 'Bearer $token');
    print(uri);

    request.add(utf8.encode(json.encode(body)));

    try {
      HttpClientResponse response = await request.close();
      String reply = await response.transform(utf8.decoder).join();
      return new Response(
          code: response.statusCode, response: jsonDecode(reply));
    } catch (error) {
      return new Response(code: 502, response: null);
    }
  }
}
