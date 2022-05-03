import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contact_form.dart';
import 'package:bytebank/screens/transactions_form.dart';
import 'package:flutter/material.dart';

import '../database/dao/contact_dao.dart';

class TransfersList extends StatefulWidget {
  const TransfersList({Key? key}) : super(key: key);

  @override
  State<TransfersList> createState() => _TransfersListState();
}

class _TransfersListState extends State<TransfersList> {
  List<Contact> contacts = [];
  final ContactDao _dao = ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transfer')),
      body: FutureBuilder(
        future: _dao.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              if (snapshot.hasData) {
                final List<Contact> contacts = snapshot.data as List<Contact>;
                return ListView.builder(
                  itemBuilder: (context, index) {
                    Contact? contact = contacts[index];
                    return _ContactItem(
                        contact: contact,
                        onClick: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  TransactionForm(contact: contact)));
                        });
                  },
                  itemCount: contacts.length,
                );
              }
              return const Center(child: Text('No data'));
            default:
              return const Center(child: Text('Unknown Error'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (_) => const ContactForm(),
            ),
          )
              .then((value) {
            setState(() {});
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final Contact contact;
  final Function onClick;

  const _ContactItem({required this.contact, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          debugPrint('test');
          onClick();
        },
        title: Text(
          contact.name,
          style: const TextStyle(fontSize: 24.0, color: Colors.black),
        ),
        subtitle: Text(
          contact.accountNumber.toString(),
        ),
      ),
    );
  }
}
