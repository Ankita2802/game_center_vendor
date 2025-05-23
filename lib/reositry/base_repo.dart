//Third Party Imports
import 'dart:convert';
import 'dart:developer';
import 'package:game_center_vendor/utils/app_urls.dart';
import 'package:game_center_vendor/utils/my_sharepreference.dart';
import 'package:http/http.dart' as http;

class BaseRepository {
  /// For POST request
  Future<http.Response> postHttp({
    required Map<String, dynamic> data,
    required String api,
    bool token = false,
  }) async {
    String? accessToken;
    final url = api;
    log(url, name: 'postHttp');
    log(data.toString(), name: '$api data');
    if (token) {
      accessToken = await MySharedPreferences.instance.getStringValue(
        "access_token",
      );
      log(accessToken.toString(), name: "access_token");
    }

    final response = await http.post(
      Uri.parse(url),
      headers:
          accessToken == null
              ? {'Content-Type': 'application/json'}
              : {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $accessToken',
              },
      body: json.encode(data),
    );
    log(response.statusCode.toString(), name: "Status Code");
    if (response.statusCode == 401 && token) {
      // signOut();
      return refreshToken().then((value) {
        if (value == 200) {
          return postHttp(data: data, api: api, token: token);
        }
        return http.Response(json.encode({}), 404);
      });
    }
    return response;
  }

  /// For GET request
  Future<http.Response> getHttp({
    required String api,
    bool token = false,
  }) async {
    String? accessToken;
    //  =   "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI5ZDQ0OTNkYy00MjJhLTRiOGYtYTk2OS1jODczYmRhMDllMjMiLCJpYXQiOjE3MDMxNjA0MDEsIm5iZiI6MTcwMzE2MDQwMSwianRpIjoiNDVhZmU2MzgtYTAyYi00NzgzLTlhMTgtNjFiN2JmNDIzNWE3IiwiZXhwIjoxNzAzMTY0MDAxLCJ0eXBlIjoiYWNjZXNzIiwiZnJlc2giOmZhbHNlfQ.EeHmpisa2fwQ0X6qPxmDE3McZqgk9rjvl4M8VFmKxqY";
    final url = api;
    log(url, name: 'getHttp');
    if (token) {
      accessToken = await MySharedPreferences.instance.getStringValue(
        "access_token",
      );
      log(accessToken.toString(), name: "access_token");
    }

    final response = await http.get(
      Uri.parse(url),
      headers:
          accessToken == null
              ? {'Content-Type': 'application/json'}
              : {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $accessToken',
              },
    );
    log(response.statusCode.toString(), name: api);
    if (response.statusCode == 401 && token) {
      // signOut();
      return refreshToken().then((value) {
        if (value == 200) {
          return getHttp(api: api, token: token);
        }
        return http.Response(json.encode({}), 404);
      });
    }
    return response;
  }

  /// For PUT request
  Future<http.Response> putHttp({
    required Map<String, dynamic> data,
    required String api,
    bool token = false,
  }) async {
    String? accessToken;
    final url = api;
    log(url, name: 'putHttp');
    log(data.toString(), name: '$api data');
    if (token) {
      accessToken = await MySharedPreferences.instance.getStringValue(
        "access_token",
      );
      log(accessToken.toString(), name: "access_token");
    }
    final response = await http.put(
      Uri.parse(url),
      headers:
          accessToken == null
              ? {'Content-Type': 'application/json'}
              : {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $accessToken',
              },
      body: json.encode(data),
    );
    log(response.statusCode.toString());
    if (response.statusCode == 401 && token) {
      // signOut();
      return refreshToken().then((value) {
        if (value == 200) {
          return putHttp(data: data, api: api, token: token);
        }
        return http.Response(json.encode({}), 404);
      });
    }
    return response;
  }

  /// For DELETE request
  Future<http.Response> deleteHttp({
    required String api,
    bool token = false,
  }) async {
    String? accessToken;
    final url = api;
    log(url, name: 'deleteHttp');
    if (token) {
      accessToken = await MySharedPreferences.instance.getStringValue(
        "access_token",
      );
      log(accessToken.toString(), name: "access_token");
    }

    final response = await http.delete(
      Uri.parse(url),
      headers:
          accessToken == null
              ? {'Content-Type': 'application/json'}
              : {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $accessToken',
              },
    );
    log(response.toString());
    if (response.statusCode == 401 && token) {
      // signOut();
      // return refreshToken().then((value) => deleteHttp(api: api, token: token));
    }
    return response;
  }

  Future<int> refreshToken() async {
    String? refreshToken = await MySharedPreferences.instance.getStringValue(
      "refresh_token",
    );
    final url = ApiUrls.userUrl + UserUrls.refreshToken;
    log(refreshToken.toString(), name: 'refreshToken');

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $refreshToken',
      },
    );
    log(response.body, name: 'response refreshToken');
    if (response.statusCode == 200) {
      String accessToken = json.decode(response.body)['data']["access_token"];
      String refreshToken = json.decode(response.body)['data']["refresh_token"];
      MySharedPreferences.instance.setStringValue("access_token", accessToken);
      MySharedPreferences.instance.setStringValue(
        "refresh_token",
        refreshToken,
      );
    }
    return response.statusCode;
  }
}
