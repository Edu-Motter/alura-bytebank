import 'contact.dart';

class Transaction {
  final double value;
  final Contact contact;

  Transaction(this.value, this.contact);

  @override
  String toString() {
    return 'Transaction{value: $value, contact: $contact}';
  }

  Map<String, dynamic> toMap() {
    return {'value': value, 'contact': contact.toMap()};
  }
}
