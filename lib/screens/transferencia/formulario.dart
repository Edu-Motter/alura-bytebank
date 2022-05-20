import 'package:bytebank/models/transferencias.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/editor_texto.dart';
import '../../models/saldo.dart';
import '../../models/transferencia.dart';

const String _tituloAppBar = 'Criando Transferências';
const String _rotuloNumeroConta = 'Número da Conta';
const String _dicaNumeroConta = '0000';
const String _rotuloValor = 'Valor';
const String _dicaValor = '0.00';
const String _textoBotaoConfirmar = 'Confirmar';

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controladorValor = TextEditingController();
  final TextEditingController _controladorNumeroConta = TextEditingController();

  FormularioTransferencia({Key? key}) : super(key: key);

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
    bool tranferenciaValida = _validaTransferencia(context, valor, numeroConta);
    if (tranferenciaValida) {
      final novaTransferencia = Transferencia(valor!, numeroConta!);
      _atualizaEstado(context, novaTransferencia, valor);
    }
  }

  _validaTransferencia(BuildContext context, double? valor, int? numeroConta){
    bool camposValidos = valor != null && numeroConta != null;
    bool saldoSuficiente = valor! <= Provider.of<Saldo>(context, listen: false).valor;
    return saldoSuficiente && camposValidos;
  }

  void _atualizaEstado(BuildContext context, Transferencia novaTransferencia, double valor) {
    Provider.of<Transferencias>(context, listen: false).adiciona(novaTransferencia);
    Provider.of<Saldo>(context, listen: false).subtrai(valor);
    Navigator.pop(context);
  }
}
