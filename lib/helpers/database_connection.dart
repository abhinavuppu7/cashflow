import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:cashflow/datamodels/tranasactionmodel.dart';

class DataBaseConnection {
  static final DataBaseConnection instance = DataBaseConnection._instance();
  static const String TABLE_TRANSACTIONS = "transactions";
  static const String COLUMN_ID = "id";
  static const String COLUMN_AMOUNT = "amount";
  static const String COLUMN_TRANSACTIONTYPE = "transactiontype";
  static const String COLUMN_DESCRIPTION = "description";
  String EXPENSE = "Expense";
  String INCOME = "Income";

  static Database _db;
  DataBaseConnection._instance();

  var transactions = 'transactions';

  Future<Database> get db async {
    if (_db == null) {
      _db = await _initializeDatabase();
    }
    return _db;
  }

  Future<Database> _initializeDatabase() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'transactions_list.db';
    final transactionListDb =
        await openDatabase(path, version: 1, onCreate: _createDB);
    return transactionListDb;
  }

  void _createDB(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $TABLE_TRANSACTIONS($COLUMN_ID INTEGER  PRIMARY KEY AUTOINCREMENT , $COLUMN_TRANSACTIONTYPE TEXT,$COLUMN_AMOUNT INTEGER, $COLUMN_DESCRIPTION TEXT)');
  }

  Future<List<Map<String, dynamic>>> getTransactionMapList() async {
    Database db = await this.db;
    final List<Map<String, dynamic>> result =
        await db.query(TABLE_TRANSACTIONS);
    return result;
  }

  Future<List<Transactions>> getTransactions() async {
    final List<Map<String, dynamic>> transactionMapList =
        await getTransactionMapList();
    final List<Transactions> TransactioList = [];
    transactionMapList.forEach(
      (transactionmap) {
        TransactioList.add(Transactions.fromMap(transactionmap));
      },
    );
    return TransactioList;
  }

  Future<int> insertTransaction(Transactions transaction) async {
    Database db = await this.db;
    final int result = await db.insert(TABLE_TRANSACTIONS, transaction.toMap());
    return result;
  }

  Future<int> updateTransaction(Transactions transaction) async {
    Database db = await this.db;
    final int result = await db.update(
      TABLE_TRANSACTIONS,
      transaction.toMap(),
      where: '$COLUMN_ID=?',
      whereArgs: [transaction.id],
    );
    return result;
  }

  Future<List<Map<String, dynamic>>> getSum() async {
    Database db = await this.db;

    final List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT SUM(amount) as sum_count from transactions ');
    return result.toList();
  }

  Future<List<Map<String, dynamic>>> getIncome() async {
    Database db = await this.db;

    final List<Map<String, dynamic>> result = await db.rawQuery(
        'SELECT SUM(amount) as sum_income FROM transactions WHERE transactiontype=\"Income\"');
    return result.toList();
  }

  Future<List<Map<String, dynamic>>> getExpense() async {
    Database db = await this.db;

    final List<Map<String, dynamic>> result = await db.rawQuery(
        'SELECT SUM(amount) as sum_expense FROM transactions WHERE transactiontype="Expense" ');
    return result.toList();
  }
}
