import 'dart:convert';

import 'package:http/http.dart';

import '../../models/transaction.dart';
import '../webclient.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    final Response response =
        await client.get(baseUrl).timeout(const Duration(seconds: 5));
    final List<dynamic> jsonBody = jsonDecode(response.body);
    return jsonBody.map((dynamic) => Transaction.fromJson(dynamic)).toList();
  }

  Future<Transaction> save(Transaction transaction) async {
    final Response response = await client
        .post(
          baseUrl,
          headers: headers,
          body: jsonEncode(transaction.toJson()),
        )
        .timeout(const Duration(seconds: 5));

    Map<String, dynamic> json = jsonDecode(response.body);
    return Transaction.fromJson(json);
  }
}
