import 'package:bytebank/components/container.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contact_form.dart';
import 'package:bytebank/screens/transactions_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../database/dao/contact_dao.dart';

@immutable
abstract class TransfersListState {
  const TransfersListState();
}

@immutable
class InitTransfersListState extends TransfersListState {
  const InitTransfersListState();
}

@immutable
class LoadingTransfersListState extends TransfersListState {
  const LoadingTransfersListState();
}

@immutable
class LoadedTransfersListState extends TransfersListState {
  final List<Contact> _contacts;
  const LoadedTransfersListState(this._contacts);
  List<Contact> get contactsList => _contacts;
}

@immutable
class FatalErrorTransfersListState extends TransfersListState {
  const FatalErrorTransfersListState();
}

class TransfersListCubit extends Cubit<TransfersListState> {
  TransfersListCubit() : super(const InitTransfersListState());

  void reload(ContactDao dao) {
    emit(const LoadingTransfersListState());
    dao.findAll().then((contacts) => emit(LoadedTransfersListState(contacts)));
  }
}

class TransfersListContainer extends BlocContainer {
  const TransfersListContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ContactDao _dao = ContactDao();

    return BlocProvider<TransfersListCubit>(
        create: (context) {
          final cubit = TransfersListCubit();
          cubit.reload(_dao);
          return cubit;
        },
        child: TransfersList(dao: _dao));
  }
}

class TransfersList extends StatelessWidget {
  final ContactDao dao;
  const TransfersList({Key? key, required this.dao}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transfer')),
      body: BlocBuilder<TransfersListCubit, TransfersListState>(
          builder: (context, state) {
        if (state is InitTransfersListState ||
            state is LoadingTransfersListState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is LoadedTransfersListState) {
          final List<Contact> contacts = state.contactsList;
          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              Contact? contact = contacts[index];
              return _ContactItem(
                  contact: contact,
                  onClick: () {
                    push(context, TransactionFormContainer(contact: contact));
                  });
            },
          );
        }

        return const Center(child: Text('Unknown Error'));
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const ContactForm(),
            ),
          );

          update(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void update(BuildContext context) {
    context.read<TransfersListCubit>().reload(dao);
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
