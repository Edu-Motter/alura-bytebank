import 'package:bytebank/screens/contacts_list.dart';
import 'package:bytebank/screens/transactions_list.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
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
                            title: 'Transfer',
                            onClick: () {
                              _showTransfersList(context);
                            }),
                        FeatureItem(
                            icon: Icons.description,
                            title: 'Transaction Feed',
                            onClick: () {
                              _showTransactionList(context);
                            }),
                      ],
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }

  void _showTransfersList(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ContactList(),
      ),
    );
  }

  void _showTransactionList(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => TransactionsList()));
  }
}

class FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onClick;

  const FeatureItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.onClick,
  }) : super(key: key);

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
