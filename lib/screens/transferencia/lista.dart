import 'package:flutter/material.dart';

import '../../models/transferencia.dart';
import 'formulario.dart';

const String _tituloAppBar = 'Bytebank';

class ListaTransferencias extends StatefulWidget {
  final List<Transferencia> _tranferencias =
      List.filled(1, Transferencia(100.50, 102), growable: true);

  ListaTransferencias({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciasState();
  }
}

class ListaTransferenciasState extends State<ListaTransferencias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(_tituloAppBar)),
      body: ListView.builder(
        itemCount: widget._tranferencias.length,
        itemBuilder: (context, index) {
          final Transferencia transferencia = widget._tranferencias[index];
          return ItemTransferencia(transferencia: transferencia);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return const FormularioTransferencia();
          })).then((transferenciaRecebida) {
            if (transferenciaRecebida != null) {
              setState(() {
                widget._tranferencias.add(transferenciaRecebida);
              });
            }
            return null;
          });
        },
      ),
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia transferencia;

  const ItemTransferencia({Key? key, required this.transferencia})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.monetization_on),
        title: Text(transferencia.valor.toString()),
        subtitle: Text(transferencia.numeroConta.toString()),
      ),
    );
  }
}
