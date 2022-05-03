class Contact {
  final int id;
  final String name;
  final int accountNumber;

  Contact(
    this.id,
    this.name,
    this.accountNumber,
  );

  @override
  String toString() {
    return 'Contact{id: $id, name: $name, accountNumber: $accountNumber}';
  }

  Contact.fromJson(Map<String, dynamic> json)
      : id = 0,
        name = json['name'],
        accountNumber = json['accountNumber'] as int;

  Map<String, dynamic> toMap() {
    return {'name': name, 'accountNumber': accountNumber};
  }
}
