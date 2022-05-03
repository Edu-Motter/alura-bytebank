import 'dart:convert';

import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:http_interceptor/http/interceptor_contract.dart';
import 'package:http_interceptor/models/models.dart';

import '../models/transaction.dart';

Client client = InterceptedClient.build(interceptors: [LoggingInterceptor()]);

Uri baseUrl = Uri.parse('http://192.168.100.11:8080/transactions');

Map<String, String> headers = {
  "password": "1000",
  "Content-type": "application/json"
};

Future<List<Transaction>> findAll() async {
  final Response response =
      await client.get(baseUrl).timeout(const Duration(seconds: 5));
  final List<dynamic> json = jsonDecode(response.body);
  final List<Transaction> transactions = [];
  for (Map<String, dynamic> map in json) {
    Transaction transaction =
        Transaction(map['value'], Contact.fromJson(map['contact']));
    transactions.add(transaction);
  }

  return transactions;
}

Future<Transaction> save(Transaction transaction) async {
  final Response response = await client
      .post(
        baseUrl,
        headers: headers,
        body: jsonEncode(transaction.toMap()),
      )
      .timeout(const Duration(seconds: 5));

  Map<String, dynamic> map = jsonDecode(response.body);
  return Transaction(map['value'], Contact.fromJson(map['contact']));
}

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
