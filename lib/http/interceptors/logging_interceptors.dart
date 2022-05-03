import 'package:flutter/material.dart';
import 'package:http_interceptor/http/interceptor_contract.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:http_interceptor/models/response_data.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    debugPrint('\n--- Request ---');
    debugPrint('Url: ${data.url}');
    debugPrint('Headers: ${data.headers.toString()}');
    debugPrint('Body: ${data.body}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    debugPrint('\n--- Response ---');
    debugPrint('Status code: ${data.statusCode}');
    debugPrint('Headers: ${data.headers.toString()}');
    debugPrint('Body: ${data.body}');
    return data;
  }
}
