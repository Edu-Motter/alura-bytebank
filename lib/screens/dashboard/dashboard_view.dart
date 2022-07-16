import 'package:bytebank/components/container.dart';
import 'package:bytebank/screens/contacts_list.dart';
import 'package:bytebank/screens/dashboard/dashboard_feature_item.dart';
import 'package:bytebank/screens/dashboard/dashboard_i18n.dart';
import 'package:bytebank/screens/name.dart';
import 'package:bytebank/screens/transactions_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/name.dart';

class DashboardView extends StatelessWidget {
  final DashboardViewLazyI18N i18n;

  const DashboardView(this.i18n, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<NameCubit, String>(
            builder: (context, name) => Text('Welcome $name')),
      ),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset('images/bytebank_logo.png'),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    FeatureItem(
                        icon: Icons.monetization_on,
                        title: i18n.transfer,
                        onClick: () {
                          _showTransfersList(context);
                        }),
                    FeatureItem(
                        icon: Icons.description,
                        title: i18n.transaction_feed,
                        onClick: () {
                          _showTransactionList(context);
                        }),
                    FeatureItem(
                        icon: Icons.person,
                        title: i18n.change_name,
                        onClick: () {
                          _showChangeName(context);
                        }),
                  ],
                ),
              )
            ]),
      ),
    );
  }

  void _showTransfersList(BuildContext context) {
    push(context, const TransfersListContainer());
  }

  void _showTransactionList(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => TransactionsList()));
  }

  void _showChangeName(BuildContext blocContext) {
    Navigator.of(blocContext).push(MaterialPageRoute(
        builder: (context) => BlocProvider.value(
              value: BlocProvider.of<NameCubit>(blocContext),
              child: const NameContainer(),
            )));
  }
}