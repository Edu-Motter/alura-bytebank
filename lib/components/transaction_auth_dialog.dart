import 'package:flutter/material.dart';

class TransactionAuthDialog extends StatefulWidget {

  static const textFieldPasswordKey = Key('textFieldPassword');
  final Function(String password) onConfirm;

  const TransactionAuthDialog({Key? key, required this.onConfirm}) : super(key: key);

  @override
  State<TransactionAuthDialog> createState() => _TransactionAuthDialogState();
}

class _TransactionAuthDialogState extends State<TransactionAuthDialog> {

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Authenticate'),
      content: TextField(
        key: TransactionAuthDialog.textFieldPasswordKey,
        controller: _passwordController,
        obscureText: true,
        maxLength: 4,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 64, letterSpacing: 32),
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          border: OutlineInputBorder()
        ),
      ),
      actions: [
        TextButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: const Text('Cancel')),
        TextButton(onPressed: (){
            widget.onConfirm(_passwordController.text);
            Navigator.of(context).pop();
          }, child: const Text('Confirm'))
      ],
    );
  }
}
