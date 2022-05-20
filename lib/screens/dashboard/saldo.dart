import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/saldo.dart';

class SaldoCard extends StatelessWidget {
  const SaldoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Consumer<Saldo>(builder: (context, saldo, child) {
          return Text(
            saldo.toString(),
            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          );
        }),
      ),
    );
  }
}
