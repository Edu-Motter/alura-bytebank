import 'package:bytebank/components/editor_texto.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/saldo.dart';

class FormularioDeposito extends StatelessWidget {
  final TextEditingController _valueController = TextEditingController();

  FormularioDeposito({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receber depósito'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            EditorTexto(
                icone: const Icon(Icons.monetization_on),
                controller: _valueController,
                rotulo: 'Valor',
                dica: '0.00'),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                    onPressed: () => _criarDeposito(context),
                    child: const Text('Confirmar')),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _criarDeposito(BuildContext context) {
    final double? valor = double.tryParse(_valueController.text);
    if(valor != null){
      Provider.of<Saldo>(context, listen:false).adiciona(valor);
      Navigator.of(context).pop();
    }
  }
}
