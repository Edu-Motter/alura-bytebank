import 'package:flutter/material.dart';

class ProgressView extends StatelessWidget {
  final String message;

  const ProgressView({Key? key, this.message = 'Sending..'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(message)),
      body: const Center(child: CircularProgressIndicator()),
    );
  }
}
