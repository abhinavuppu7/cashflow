class Transactions {
  static String table = "transactions";
  int id;

  String transactiontype;
  String description;
  String category;
  DateTime date;

  int amount;

  Transactions(
      {this.amount,
      this.description,
      this.transactiontype,
      this.date,
      this.category});
  Transactions.WithID(
      {this.id,
      this.amount,
      this.description,
      this.transactiontype,
      this.date,
      this.category});

  factory Transactions.fromMap(Map<String, dynamic> map) {
    return Transactions.WithID(
      id: map['id'],
      transactiontype: map['transactiontype'],
      description: map['description'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),
      category: map['category'],
    );
  }

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    if (id != null) map['id'] = id;

    map['transactiontype'] = transactiontype;
    map['description'] = description;
    map['amount'] = amount;
    map['category'] = category;
    map['date'] = date.toIso8601String();
    return map;
  }
}
