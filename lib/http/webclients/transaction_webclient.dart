import 'dart:convert';

import 'package:http/http.dart';

import '../../models/transaction.dart';
import '../webclient.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    final Response response =
        await client.get(baseUrl);
    final List<dynamic> jsonBody = jsonDecode(response.body);
    return jsonBody.map((dynamic) => Transaction.fromJson(dynamic)).toList();
  }

  Future<Transaction> save(Transaction transaction, String password) async {
    final Response response = await client
        .post(
          baseUrl,
          headers: {'password': password, 'Content-type': 'application/json'},
          body: jsonEncode(transaction.toJson()),
        );

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      return Transaction.fromJson(json);
    }

    throw HttpException(_getMessage(response.statusCode));
  }

  String? _getMessage(int statusCode){
    if (_httpExceptions.containsKey(statusCode)){
      return _httpExceptions[statusCode];
    }
    return 'unknown error';
  }

  static final Map<int, String> _httpExceptions = {
    400: 'there was an error submitting transaction',
    401: 'authentication failed',
    409: 'transactions already exists'
  };
}

class HttpException implements Exception {
  final String? message;

  HttpException(this.message);
}
