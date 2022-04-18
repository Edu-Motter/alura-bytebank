import 'package:flutter/material.dart';

import '../../components/editor_texto.dart';
import '../../models/transferencia.dart';

const String _tituloAppBar = 'Criando Transferências';
const String _rotuloNumeroConta = 'Número da Conta';
const String _dicaNumeroConta = '0000';
const String _rotuloValor = 'Valor';
const String _dicaValor = '0.00';
const String _textoBotaoConfirmar = 'Confirmar';

class FormularioTransferencia extends StatefulWidget {
  const FormularioTransferencia({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaState();
  }
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {
  final TextEditingController _controladorValor = TextEditingController();
  final TextEditingController _controladorNumeroConta = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_tituloAppBar),
      ),
      body: Stack(children: [
        Column(
          children: [
            EditorTexto(
                icone: const Icon(Icons.numbers),
                controller: _controladorNumeroConta,
                rotulo: _rotuloNumeroConta,
                dica: _dicaNumeroConta),
            EditorTexto(
                icone: const Icon(Icons.monetization_on),
                controller: _controladorValor,
                rotulo: _rotuloValor,
                dica: _dicaValor),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
                onPressed: () => _criarTransferencia(context),
                child: const Text(_textoBotaoConfirmar)),
          ),
        )
      ]),
    );
  }

  void _criarTransferencia(BuildContext context) {
    final double? valor = double.tryParse(_controladorValor.text);
    final int? numeroConta = int.tryParse(_controladorNumeroConta.text);
    if (valor != null && numeroConta != null) {
      final transferenciaCriada = Transferencia(valor, numeroConta);
      Navigator.pop(context, transferenciaCriada);
    }
  }
}
