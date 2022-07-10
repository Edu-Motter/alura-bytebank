import 'package:bytebank/components/container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/name.dart';

class NameContainer extends BlocContainer {
  const NameContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NameView();
  }
}

class NameView extends StatelessWidget {
  NameView({Key? key}) : super(key: key);

  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _nameController.text = context.read<NameCubit>().state;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Change name'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Desired name:'),
            style: const TextStyle(fontSize: 24.0),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
              onPressed: () {
                final name = _nameController.text;
                context.read<NameCubit>().change(name);
                Navigator.pop(context);
              },
              child: const Text('Change'))
        ],
      ),
    );
  }
}
