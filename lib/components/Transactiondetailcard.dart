import 'package:cashflow/datamodels/tranasactionmodel.dart';
import 'package:cashflow/screens/AddTransaction.dart';
import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {
  TransactionTile({
    @required this.catmap,
    @required this.description,
    @required this.transactiontype,
    @required this.transactionamount,
    @required this.transactioncategory,
    @required this.catcol,
    @required this.transactiondate,
    @required this.transaction,
    // @required this.updateAmount,
    // @required this.updatetransactionList,
  });
  final Map<String, IconData> catmap;
  final String description;
  final String transactiontype;
  final String transactioncategory;
  final int transactionamount;
  final Map<String, Color> catcol;
  final String transactiondate;
  final Transactions transaction;
  // final Function updateAmount;
  // final Function updatetransactionList;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      // color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 20,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: catcol[transactioncategory],
          radius: 25,
          child: Icon(
            catmap[transactioncategory],
            color: Colors.white,
            size: 40,
          ),
        ),
        title: Text(
          description,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        subtitle: Text(transactiondate, style: TextStyle(fontSize: 15)),
        trailing: Text(
          transactiontype == "Expense"
              ? "-" + '${transactionamount}'
              : "+" + '${transactionamount}',
          style: TextStyle(
              color: transactiontype == "Expense" ? Colors.red : Colors.green,
              fontSize: 20,
              fontWeight: FontWeight.w900),
        ),
        // onTap: () {
        //   Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //           builder: (_) => AddTransaction(
        //                 UpdateTransactionList: updatetransactionList,
        //                 UpdateAmount: updateAmount,
        //                 transaction: transaction,
        //               )));
        // },
      ),
    );
  }
}
