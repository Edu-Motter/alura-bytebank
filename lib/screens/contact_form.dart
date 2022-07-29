import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';

import '../models/contact.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({Key? key}) : super(key: key);

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                controller: _fullNameController,
                decoration: const InputDecoration(labelText: 'Full name'),
                style: const TextStyle(fontSize: 24.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                controller: _accountNumberController,
                decoration: const InputDecoration(labelText: 'Account number'),
                style: const TextStyle(fontSize: 24.0),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () {
                    final String fullName = _fullNameController.text;
                    final int? accountNumber =
                        int.tryParse(_accountNumberController.text);
                    if (accountNumber != null) {
                      _save(
                        dependencies.contactDao,
                        Contact(1, fullName, accountNumber),
                        context,
                      );
                    }
                  },
                  child: const Text('Create'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _save(
      ContactDao contactDao, Contact newContact, BuildContext context) async {
    contactDao.save(newContact);
    Navigator.pop(context);
  }
}
