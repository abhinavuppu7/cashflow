import 'package:cashflow/screens/AddTransaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cashflow/helpers/database_connection.dart';
import 'package:cashflow/datamodels/tranasactionmodel.dart';

class Homescreen extends StatefulWidget {
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int amount = 0, income = 0, expense = 0;
  Future<List<Transactions>> _transactionList;
  Future<List> amounthelper;
  Future<List> incomehelper;
  Future<List> expensehelper;
  List amounts;
  List incomes;
  List expenses;

  @override
  void initState() {
    super.initState();
    //   _getAmount();
    _UpdateTransactionList();
    _UpdateAmount();
  }

  _getAmount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    amount = prefs.getInt('cashbalance');
    setState(() {
      amount;
    });
  }

  _UpdateAmount() async {
    amounthelper = DataBaseConnection.instance.getSum();
    incomehelper = DataBaseConnection.instance.getIncome();
    expensehelper = DataBaseConnection.instance.getExpense();

    amounts = await amounthelper;
    print(amounts[0]['sum_count']);
    incomes = await incomehelper;
    print(incomes[0]['sum_income']);

    expenses = await expensehelper;
    print(expenses[0]['sum_expense']);
    setState(() {
      amount = amounts[0]['sum_count'];
      income = incomes[0]['sum_income'];
      expense = expenses[0]['sum_expense'];
    });
  }

  _UpdateTransactionList() {
    setState(() {
      _transactionList = DataBaseConnection.instance.getTransactions();
    });
  }

  Widget _buildTransaction(Transactions transaction) {
    return Container(
      height: 57,
      margin: EdgeInsets.only(left: 15, bottom: 15, right: 15),
      padding: EdgeInsets.only(left: 24, top: 12, bottom: 12, right: 22),
      decoration: BoxDecoration(
        color: Color(0xfffcf1f1),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF3A3A3A),
            blurRadius: 10,
            spreadRadius: 5,
            offset: Offset(8.0, 8.0),
          )
        ],
      ),
      child: ListTile(
        title: Text(transaction.description),
        trailing: Text('${transaction.amount}'),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => AddTransaction(
                        UpdateTransactionList: _UpdateTransactionList,
                        UpdateAmount: _UpdateAmount(),
                        transaction: transaction,
                      )));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.add,
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return AddTransaction(
                UpdateTransactionList: _UpdateTransactionList,
                UpdateAmount: _UpdateAmount,
              );
            }));
          }),
      body: FutureBuilder(
        future: _transactionList,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 80.0),
              itemCount: 1 + snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 40, vertical: 20.0),
                    child: Column(children: <Widget>[
                      Row(children: <Widget>[
                        Expanded(
                            child: Container(
                          child: Column(
                            children: <Widget>[
                              Text('Amount'),
                              Text('${amount}')
                            ],
                          ),
                        )),
                      ]),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                              child: Container(
                            child: Column(
                              children: <Widget>[
                                Text('Income'),
                                Text('${income}')
                              ],
                            ),
                          )),
                          Expanded(
                              child: Container(
                            child: Column(
                              children: <Widget>[
                                Text('Expenses'),
                                Text('${expense}')
                              ],
                            ),
                          ))
                        ],
                      )
                    ]),
                  );
                }
                return _buildTransaction(snapshot.data[index - 1]);
              });
        },
      ),
    );
  }
}
