import 'package:bytebank/http/webclient.dart';
import 'package:flutter/material.dart';

import '../models/transaction.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
      ),
      body: FutureBuilder<List<Transaction>>(
        future: Future.delayed(const Duration(seconds: 2))
            .then((value) => findAll()),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());

            case ConnectionState.done:
              if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                List<Transaction> transactions = snapshot.data!;
                return ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      final Transaction transaction = transactions[index];
                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.monetization_on),
                          title: Text(
                            transaction.value.toString(),
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            transaction.contact.accountNumber.toString(),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      );
                    });
              }
              return const Center(
                  child: Text('Não foi possível encontrar transações'));

            default:
              return const Center(child: Text('Unknown Error'));
          }
        },
      ),
    );
  }
}
