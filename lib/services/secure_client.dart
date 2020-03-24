import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/io_client.dart' as inner;
import 'package:news/utils/constants.dart';





class SecureClient {
  SecureClient(this.token);
  String token;
  Future<dynamic> post(String url,Map data,
      {String bodyContentType}) async {
//    if (data == null) throw ('Asset is Required');
    final String _token = token ?? "";
    //encode Map to JSON
    var body = json.encode(data);
    final http.Response response = await getHttpReponse(
      url,
      body: body,
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $_token",
        "content-type":"application/json"
      },
      method: HttpMethod.post,
    );

    if (response.headers.containsValue("json"))
      return json.decode(response.body);

    return response.body;
  }
  Future<dynamic> get(String url, {Map data}) async {
    http.Response response  ;
    if (token == null) throw ('Token is Required');
    final String _token = token ?? "";
    if (data != null){
      response = await getHttpReponse(
        url,
        body: data,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $_token",
          "content-type":"application/json"
        },
        method: HttpMethod.get,
      );
    }
     response = await getHttpReponse(
      url,
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $_token",
        "content-type":"application/json"
      },
      method: HttpMethod.get,
    );

    if (response.headers.containsValue("json"))
      return json.decode(response.body);

    return response.body;
  }


  Future<http.Response> getHttpReponse(
      String url, {
        dynamic body,
        Map<String, String> headers,
        HttpMethod method = HttpMethod.get,
      }) async {
    final inner.IOClient _client = getClient();
    http.Response response;
    try {
      switch (method) {
        case HttpMethod.post:
          response = await _client.post(
            url,
            body: body,
            headers: headers,
          );
          break;
        case HttpMethod.put:
          response = await _client.put(
            url,
            body: body,
            headers: headers,
          );
          break;
        case HttpMethod.delete:
          response = await _client.delete(
            url,
            headers: headers,
          );
          break;
        case HttpMethod.get:
          response = await _client.get(
            url,
            headers: headers,
          );
      }

      print("URL: $url");
      print("Body: $body");
      print("Response Code: " + response.statusCode.toString());
      print("Response Body: " + response.body.toString());

      if (response.statusCode >= 400) {
        // if (response.statusCode == 404) return response.body; // Not Found Message
        if (response.statusCode == 401) {

        } // Not Authorized
        if (devMode) throw ('An error occurred: ' + response.body);
      }
    } catch (e) {
      print('Error with URL: $e');
    }

    return response;
  }

  inner.IOClient getClient() {
    bool trustSelfSigned = true;
    HttpClient httpClient = new HttpClient()
      ..badCertificateCallback =
      ((X509Certificate cert, String host, int port) => trustSelfSigned);
    inner.IOClient ioClient = new inner.IOClient(httpClient);
    return ioClient;
  }
}

enum HttpMethod { get, post, put, delete }
