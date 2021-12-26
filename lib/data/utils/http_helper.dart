import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:coupon_app/app/utils/config.dart';
import 'package:coupon_app/app/utils/utility.dart';
import 'package:coupon_app/domain/utils/session_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:coupon_app/data/exceptions/authentication_exception.dart';
import 'package:coupon_app/data/utils/constants.dart';

/// A `static` helepr for `HTTP` requests throughout the application.
class HttpHelper {

  /// Invokes an `http` request given.
  /// [url] can either be a `string` or a `Uri`.
  /// The [type] can be any of the [RequestType]s.
  /// [body] and [encoding] only apply to [RequestType.post] and [RequestType.put] requests. Otherwise,
  /// they have no effect.
  /// This is optimized for requests that anticipate a response body of type `Map<String, dynamic>`, as in a json file-type response.
  static Future<T> invokeHttp<T>(dynamic url, RequestType type, {Map<String, String> headers, dynamic body, Encoding encoding}) async {
    http.Response response;
    T responseBody;
    print("------------ ${headers}");
    print("url; ${url} _=-Body ${body}");
    try {
      response = await _invoke(url, type, headers: headers, body: body, encoding: encoding);
      if(response.body.length > 0){
        responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      }
    } catch (error) {
      rethrow;
    }

    return responseBody;
  }

  /// Invokes an `http` request given.
  /// [url] can either be a `string` or a `Uri`.
  /// The [type] can be any of the [RequestType]s.
  /// [body] and [encoding] only apply to [RequestType.post] and [RequestType.put] requests. Otherwise,
  /// they have no effect.
  /// This is optimized for requests that anticipate a response body of type `List<dynamic>`, as in a list of json objects.
  static Future<List<dynamic>> invokeHttp2(dynamic url, RequestType type, {Map<String, String> headers, dynamic body, Encoding encoding}) async {
    http.Response response;
    List<dynamic> responseBody;
    try {
      response = await _invoke(url, type, headers: headers, body: body, encoding: encoding);
    } on APIException {
      rethrow;
    } on SocketException {
      rethrow;
    }
    try{
      responseBody = jsonDecode(utf8.decode(response.bodyBytes));
    }catch(e){
      print(e);
    }
    return responseBody;
  }

  /// Invoke the `http` request, returning the [http.Response] unparsed.
  static Future<http.Response> _invoke(dynamic url, RequestType type, {Map<String, String> headers, dynamic body, Encoding encoding}) async {
    http.Response response;
    if(headers == null || headers.isEmpty) {
      headers = {};
    }
    var token = await SessionHelper().getToken();
    if(token != null){
      headers[HttpHeaders.authorizationHeader] = "Token ${await SessionHelper().getToken()}";
    }
    headers["language"] = Config().locale.languageCode ?? "en";
    try {
      var uri = Uri.parse(url);
      switch (type) {
        case RequestType.patch:
          response = await http.patch(uri, headers: headers,body: body, encoding: encoding);
          break;
        case RequestType.get:
          response = await http.get(uri, headers: headers);
          break;
        case RequestType.post:
          response = await http.post(uri,
              headers: headers, body: body, encoding: encoding);
          break;
        case RequestType.put:
          response = await http.put(uri,
              headers: headers, body: body, encoding: encoding);
          break;
        case RequestType.delete:
          response = await http.delete(uri, headers: headers);
          break;
      }
      // check for any errors
      if (response.statusCode != 200 && response.statusCode != 201) {
        if(response.body.length > 0){
          dynamic responseBody = jsonDecode(utf8.decode(response.bodyBytes));
          Logger().e(responseBody);
          if(responseBody is Map){
            var values = (responseBody as Map).entries.first.value;
            var key = (responseBody as Map).entries.first.key;
            if(values is List){
              throw APIException(
                 "${Utility.capitalize(key)} : ${values.first.toString()}" , response.statusCode,  values.first.toString());
            } else if (values is Map) {
              var firstValue = (values as Map).entries.first.value;
              var key = (values as Map).entries.first.key;
              if(firstValue is List){
                throw APIException(
                    "${Utility.capitalize(key)} : ${firstValue.first.toString()}",
                    response.statusCode,  firstValue.first.toString());
              }else if(firstValue["message"]){
                throw APIException(
                    firstValue["message"] ,
                    response.statusCode, firstValue.toString());
              }else{
                throw APIException(
                   "${Utility.capitalize(key)} : ${firstValue.toString()}" ,
                    response.statusCode, firstValue.toString());
              }

            } else {
              throw APIException(
                  values, response.statusCode, values.toString());
            }

          }else{
            print("----------------> response map");
          }
          throw APIException(
              "Something went wrong!", response.statusCode,  "api_error");
        }

      }
      print("Return ${response.statusCode}");
      return response;
    } on http.ClientException catch(e){
      print("Client Exception ${e.message}");
      // handle any 404's
      rethrow;
      // handle no internet connection
    } on SocketException catch(e) {
      print("SocketException");
      throw Exception(e.osError.message);
    } catch (error) {
      rethrow;
    }
  }
}

// types used by the helper
enum RequestType { get, post, put, patch, delete }
