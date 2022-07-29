import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contact_form.dart';
import 'package:bytebank/screens/transactions_form.dart';
import 'package:bytebank/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';

class ContactList extends StatefulWidget {
  const ContactList({Key? key}) : super(key: key);

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  List<Contact> contacts = [];

  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Transfer')),
      body: FutureBuilder(
        future: dependencies.contactDao.findAll(),
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
                    return ContactItem(
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

class ContactItem extends StatelessWidget {
  final Contact contact;
  final Function onClick;

  const ContactItem({
    Key? key,
    required this.contact,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
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
