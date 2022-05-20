import 'package:flutter/cupertino.dart';

class Saldo extends ChangeNotifier {
  double valor;

  Saldo({required this.valor});

  void adiciona(double valor){
    this.valor += valor;
    notifyListeners();
  }

  void subtrai(double valor){
    this.valor -= valor;
    notifyListeners();
  }
  @override
  String toString() {
    return 'R\$ $valor';
  }
}