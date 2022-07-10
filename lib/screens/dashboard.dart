import 'package:bytebank/components/container.dart';
import 'package:bytebank/screens/contacts_list.dart';
import 'package:bytebank/screens/name.dart';
import 'package:bytebank/screens/transactions_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/name.dart';

class DashboardContainer extends BlocContainer {
  const DashboardContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NameCubit('Eduardo'),
      child: const DashboardView(),
    );
  }
}

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

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
                    _FeatureItem(
                        icon: Icons.monetization_on,
                        title: 'Transfer',
                        onClick: () {
                          _showTransfersList(context);
                        }),
                    _FeatureItem(
                        icon: Icons.description,
                        title: 'Transaction Feed',
                        onClick: () {
                          _showTransactionList(context);
                        }),
                    _FeatureItem(
                        icon: Icons.person,
                        title: 'Change Name',
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

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onClick;

  const _FeatureItem(
      {required this.icon, required this.title, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Colors.green,
        child: InkWell(
          onTap: () => onClick(),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            height: 100,
            width: 120,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    icon,
                    color: Colors.white,
                    size: 24.0,
                  ),
                  Text(
                    title,
                    style: const TextStyle(color: Colors.white, fontSize: 16.0),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
