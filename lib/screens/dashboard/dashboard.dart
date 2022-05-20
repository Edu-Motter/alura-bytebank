import 'package:bytebank/screens/dashboard/saldo.dart';
import 'package:bytebank/screens/deposito/formulario.dart';
import 'package:bytebank/screens/transferencia/lista.dart';
import 'package:flutter/material.dart';

import '../transferencia/formulario.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Align(
                alignment: Alignment.topCenter,
                child:
                    Padding(padding: EdgeInsets.all(8.0), child: SaldoCard()),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => FormularioDeposito()));
                      },
                      child: const Text('Receber depósito')),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => FormularioTransferencia()));
                      },
                      child: const Text('Fazer transferencia'))
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    color: Colors.green,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => ListaTransferencias()));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        height: 120,
                        width: 150,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Icon(
                                Icons.monetization_on,
                                color: Colors.white,
                                size: 24.0,
                              ),
                              Text(
                                'Transferencias',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.0),
                              )
                            ]),
                      ),
                    ),
                  ),
                ),
              )
            ]),
      ),
    );
  }
}
