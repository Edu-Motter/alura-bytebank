import 'package:flutter/material.dart';

class EditorTexto extends StatelessWidget {
  final TextEditingController controller;
  final Icon icone;
  final String rotulo;
  final String dica;

  const EditorTexto({
    Key? key,
    required this.icone,
    required this.controller,
    required this.rotulo,
    required this.dica,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        style: const TextStyle(fontSize: 16.0),
        decoration: InputDecoration(
          icon: icone,
          label: Text(rotulo),
          hintText: dica,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
