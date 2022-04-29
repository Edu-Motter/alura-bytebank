import 'package:flutter/material.dart';

import '../models/contact.dart';
import '../models/transaction.dart';

class TransactionsList extends StatelessWidget {

  TransactionsList({Key? key}) : super(key: key);
  final List<Transaction> transactions = [];

  @override
  Widget build(BuildContext context) {
    transactions.add(Transaction(1000, Contact(1,'Eduardo',101)));

    return Scaffold(
      appBar: AppBar(title: const Text('Transactions'),),
      body: ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final Transaction transaction = transactions[index];
            return Card(
                child: ListTile(
                  leading: const Icon(Icons.monetization_on),
                  title: Text(
                    transaction.value.toString(),
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  subtitle: Text(
                    transaction.contact.accountNumber.toString(),
                    style: const TextStyle(
                        fontSize: 16
                    ),
                  ),
                ),
              );
        }),
    );
  }
}
