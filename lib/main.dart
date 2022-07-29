import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:bytebank/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';

import 'database/dao/contact_dao.dart';
import 'screens/dashboard.dart';

void main() {
  runApp(BytebankApp(
    contactDao: ContactDao(),
    transactionWebClient: TransactionWebClient(),
  ));
}

class BytebankApp extends StatelessWidget {
  const BytebankApp({
    Key? key,
    required this.contactDao,
    required this.transactionWebClient,
  }) : super(key: key);

  final ContactDao contactDao;
  final TransactionWebClient transactionWebClient;

  @override
  Widget build(BuildContext context) {
    return AppDependencies(
      contactDao: contactDao,
      transactionWebClient: transactionWebClient,
      appChild: MaterialApp(
        home: const Dashboard(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.green,
          ).copyWith(
            secondary: Colors.blueAccent[700],
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Colors.blueAccent[700]),
            ),
          ),
          buttonTheme: ButtonThemeData(
              buttonColor: Colors.blueAccent[700],
              textTheme: ButtonTextTheme.primary),
        ),
      ),
    );
  }
}
