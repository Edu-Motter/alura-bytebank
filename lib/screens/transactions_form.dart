import 'dart:async';

import 'package:bytebank/components/transaction_auth_dialog.dart';
import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../components/dialogs.dart';
import '../models/contact.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;
  const TransactionForm({Key? key, required this.contact}) : super(key: key);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final TransactionWebClient _webClient = TransactionWebClient();
  final String _transactionId = const Uuid().v4();

  bool _sending = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Transaction')),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Visibility(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Center(
                  child: Column(
                children: const [
                  LinearProgressIndicator(),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Sending...',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  )
                ],
              )),
            ),
            visible: _sending),
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
                    showDialog(
                        context: context,
                        builder: (_) =>
                            TransactionAuthDialog(onConfirm: (String password) {
                              final Transaction transaction = Transaction(
                                  _transactionId, value, widget.contact);
                              _save(transaction, password, context);
                            }));
                  }
                },
                child: const Text('Transfer')),
          ),
        )
      ]),
    );
  }

  void _save(
      Transaction transaction, String password, BuildContext context) async {
    Transaction transactionResult = await _send(transaction, password, context);
    if (transactionResult.value > 0) {
      _showSuccessMessage(context);
    }
  }

  Future<void> _showSuccessMessage(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (_) {
          return const SuccessDialog(message: 'Transaction created');
        });
    Navigator.of(context).pop();
  }

  Future<Transaction> _send(
      Transaction transaction, String password, BuildContext context) async {
    setState(() {
      _sending = true;
    });

    Transaction transactionResult =
        await _webClient.save(transaction, password).catchError((e) async {
      return _showFailureMessage(context, message: e.message);
    }, test: (e) => e is HttpException).catchError((e) async {
      return _showFailureMessage(context,
          message: 'Timeout when submitting the transaction. Try again');
    }, test: (e) => e is TimeoutException).catchError((e) {
      return _showFailureMessage(context);
    }, test: (e) => e is Exception).whenComplete(() {
      setState(() {
        _sending = false;
      });
    });

    return transactionResult;
  }

  Transaction _showFailureMessage(BuildContext context,
      {String message = 'Unknow Error'}) {
    showDialog(
        context: context,
        builder: (_) {
          return ExceptionDialog(message: message);
        });
    return Transaction('randomId', -1, Contact(0, 'Error', 0000));
  }
}
