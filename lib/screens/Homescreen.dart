

import 'package:cashflow/screens/AddTransaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:cashflow/helpers/database_connection.dart';
import 'package:cashflow/datamodels/tranasactionmodel.dart';

class Homescreen extends StatefulWidget {
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  Future<List<Transactions>> _transactionList;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _UpdateTransactionList();

  }
  _UpdateTransactionList()

  {
    setState(() {
      _transactionList=DataBaseConnection.instance.getTransactions();

    });


  }

  Widget _buildTransaction(Transactions transaction){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: ListTile(
        title: Text(transaction.transactiontype),
        trailing: Text('${transaction.amount}'),
onTap: (){
          Navigator.push(context,MaterialPageRoute(builder:(_)=>AddTransaction(
            UpdateTransactionList:_UpdateTransactionList,
              transaction:transaction,
          )
          ));
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
          Navigator.push(context, MaterialPageRoute(builder:(context){
            return AddTransaction(
              UpdateTransactionList: _UpdateTransactionList,

            );
          }));

      }
      ),
      body: FutureBuilder(
        future: _transactionList,
        builder: (context,snapshot) {
          if(!snapshot.hasData)
            {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          return ListView.builder(


              padding: EdgeInsets.symmetric(vertical: 80.0),
              itemCount: 1+snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('My Transactions',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,


                          ),),

                      ],
                    ),
                  );
                }
                return _buildTransaction(snapshot.data[index-1]);
              });

        },
      ),



      
    );
  }
}



