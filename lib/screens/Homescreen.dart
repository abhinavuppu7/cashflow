import 'package:cashflow/components/Reusablecard.dart';
import 'package:cashflow/components/Transactiondetailcard.dart';
import 'package:cashflow/screens/AddTransaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:cashflow/helpers/database_connection.dart';
import 'package:cashflow/datamodels/tranasactionmodel.dart';
import '../Icondata.dart';

class Homescreen extends StatefulWidget {
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int amount = 0, income = 0, expense = 0;
  Future<List<Transactions>> _transactionList;
  Future<List> incomehelper;
  Future<List> expensehelper;
  List incomes;
  List expenses;

  final DateFormat _dateformatter = DateFormat('MMM dd,yyyy');

  @override
  void initState() {
    super.initState();

    _UpdateTransactionList();
    _UpdateAmount();
  }

  _UpdateAmount() async {
    incomehelper = DataBaseConnection.instance.getIncome();
    expensehelper = DataBaseConnection.instance.getExpense();
    incomes = await incomehelper;
    print(incomes[0]['sum_income']);
    expenses = await expensehelper;
    print(expenses[0]['sum_expense']);
    setState(() {
      income = incomes[0]['sum_income'] == null ? 0 : incomes[0]['sum_income'];
      expense =
          expenses[0]['sum_expense'] == null ? 0 : expenses[0]['sum_expense'];
      amount = income - expense;
    });
  }

  _UpdateTransactionList() {
    setState(() {
      _transactionList = DataBaseConnection.instance.getTransactions();
    });
  }

  Widget _buildTransaction(Transactions transaction) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => AddTransaction(
                      UpdateTransactionList: _UpdateTransactionList,
                      UpdateAmount: _UpdateAmount,
                      transaction: transaction,
                    )));
      },
      child: TransactionTile(
        catmap: catmap,
        description: transaction.description,
        transactiontype: transaction.transactiontype,
        transactionamount: transaction.amount,
        transactioncategory: transaction.category,
        transactiondate: _dateformatter.format(transaction.date),
        catcol: catcol,
        transaction: transaction,

        // updateAmount: _UpdateAmount(),
        // updatetransactionList: _UpdateTransactionList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.greenAccent,
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
              itemCount: 1 + snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return Container(
                    child: Column(children: <Widget>[
                      Row(children: <Widget>[
                        Expanded(
                            child: DetailCard(
                                label: "CASH BALANCE",
                                value: amount,
                                colour: Colors.green)),
                      ]),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                              child: DetailCard(
                            label: "INCOME",
                            value: income,
                            colour: Colors.orange,
                          )),
                          Expanded(
                            child: DetailCard(
                                label: "EXPENSES",
                                value: expense,
                                colour: Colors.red),
                          )
                        ],
                      ),
                      Text(
                        'My Transactions',
                        style: TextStyle(color: Colors.white, fontSize: 20),
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
