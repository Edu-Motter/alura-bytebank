import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/contact.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;
  const TransactionForm({Key? key, required this.contact}) : super(key: key);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Transaction')),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.contact.name,
            style: const TextStyle(fontSize: 24.00),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            widget.contact.accountNumber.toString(),
            style:
                const TextStyle(fontSize: 32.00, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextField(
            controller: _valueController,
            style: const TextStyle(fontSize: 24.0),
            decoration: const InputDecoration(label: Text('Value')),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: SizedBox(
            width: double.maxFinite,
            child: ElevatedButton(
                onPressed: () {
                  final value = double.tryParse(_valueController.text);
                  if (value != null) {
                    final Transaction transaction =
                        Transaction(value, widget.contact);
                    save(transaction).then((transaction) {
                      if (transaction != null) {
                        Navigator.of(context).pop();
                      }
                    });
                  }
                },
                child: const Text('Transfer')),
          ),
        )
      ]),
    );
  }
}
