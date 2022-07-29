import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:flutter/material.dart';

class AppDependencies extends InheritedWidget {
  const AppDependencies({
    Key? key,
    required this.contactDao,
    required this.transactionWebClient,
    required this.appChild,
  }) : super(child: appChild, key: key);

  final ContactDao contactDao;
  final TransactionWebClient transactionWebClient;
  final Widget appChild;

  static AppDependencies of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppDependencies>()!;
  }

  @override
  bool updateShouldNotify(AppDependencies oldWidget) {
    return oldWidget.contactDao != contactDao ||
        oldWidget.transactionWebClient != transactionWebClient;
  }
}
