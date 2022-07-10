import 'dart:async';

import 'package:bytebank/components/container.dart';
import 'package:bytebank/components/transaction_auth_dialog.dart';
import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../models/contact.dart';

@immutable
abstract class TransactionFormState {
  const TransactionFormState();
}

@immutable
class ShowFormState extends TransactionFormState {
  const ShowFormState();
}

@immutable
class SendingFormState extends TransactionFormState {
  const SendingFormState();
}

@immutable
class SentFormState extends TransactionFormState {
  const SentFormState();
}

@immutable
class FatalErrorFormState extends TransactionFormState {
  final String message;
  const FatalErrorFormState(this.message);
}

class TransactionFormCubit extends Cubit<TransactionFormState> {
  TransactionFormCubit() : super(const ShowFormState());

  void save(
      Transaction transaction, String password, BuildContext context) async {
    emit(const SendingFormState());
    _send(transaction, password, context);
  }

  _send(Transaction transaction, String password, BuildContext context) async {
    await TransactionWebClient()
        .save(transaction, password)
        .then((value) => emit(const SentFormState()))
        .catchError((e) async {
      emit(FatalErrorFormState(e.message));
      if (FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled) {
        FirebaseCrashlytics.instance.setCustomKey('exception', e.toString());
        FirebaseCrashlytics.instance
            .setCustomKey('http-body', transaction.toString());
        FirebaseCrashlytics.instance.recordError(e, null);
      }
    }, test: (e) => e is HttpException).catchError((e) async {
      emit(const FatalErrorFormState(
          'Timeout when submitting the transaction. Try again'));
      if (FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled) {
        FirebaseCrashlytics.instance.setCustomKey('exception', e.toString());
        FirebaseCrashlytics.instance
            .setCustomKey('http-body', transaction.toString());
        FirebaseCrashlytics.instance.recordError(e, null);
      }
    }, test: (e) => e is TimeoutException).catchError((e) {
      emit(FatalErrorFormState(e.message));
      if (FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled) {
        FirebaseCrashlytics.instance.setCustomKey('exception', e.toString());
        FirebaseCrashlytics.instance
            .setCustomKey('http-body', transaction.toString());
        FirebaseCrashlytics.instance.recordError(e, null);
      }
    }, test: (e) => e is Exception).whenComplete(() {});
  }
}

class TransactionFormContainer extends BlocContainer {
  final Contact contact;

  const TransactionFormContainer({Key? key, required this.contact})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransactionFormCubit>(
        create: (_) => TransactionFormCubit(),
        child: BlocListener<TransactionFormCubit, TransactionFormState>(
            listener: (context, state) {
              if (state is SentFormState) {
                Navigator.of(context).pop();
              }
            },
            child: TransactionForm(contact: contact)));
  }
}

class TransactionForm extends StatelessWidget {
  final Contact contact;

  const TransactionForm({Key? key, required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionFormCubit, TransactionFormState>(
      builder: (context, state) {
        if (state is ShowFormState) {
          return BasicForm(contact: contact);
        }

        if (state is SendingFormState || state is SentFormState) {
          return const ProgressView();
        }

        if (state is FatalErrorFormState) {
          return ErrorView(message: state.message);
        }

        return const ErrorView(
          message: 'Unknow Error',
        );
      },
    );
  }
}

class BasicForm extends StatelessWidget {
  final TextEditingController _valueController = TextEditingController();
  final String _transactionId = const Uuid().v4();

  final Contact contact;
  BasicForm({Key? key, required this.contact}) : super(key: key);

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: const Text('New Transaction')),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            contact.name,
            style: const TextStyle(fontSize: 24.00),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            contact.accountNumber.toString(),
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
                              final Transaction transaction =
                                  Transaction(_transactionId, value, contact);
                              context
                                  .read<TransactionFormCubit>()
                                  .save(transaction, password, context);
                            }));
                  }
                },
                child: const Text('Transfer')),
          ),
        )
      ]),
    );
  }
}

class ProgressView extends StatelessWidget {
  const ProgressView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sending..")),
      body: const Center(child: CircularProgressIndicator()),
    );
  }
}

class ErrorView extends StatelessWidget {
  const ErrorView({Key? key, required this.message}) : super(key: key);

  final String message;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Erro..")),
      body: Center(child: Text(message)),
    );
  }
}
