import 'package:cashflow/helpers/database_connection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cashflow/datamodels/tranasactionmodel.dart';
class AddTransaction extends StatefulWidget {
  final Function UpdateTransactionList;
  final Transactions transaction;
  AddTransaction({this.UpdateTransactionList,this.transaction});
  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  @override
  void initState() {
    // TODO: implement initState


 if(widget.transaction!=null)
            {
              _transactiontype=widget.transaction.transactiontype;
              _amount=widget.transaction.amount;
            }



  }

  final _formkey=GlobalKey<FormState>( );
  String _transactiontype='';
  int _amount=0;
  final List<String>_transactionchoices=["Income","Expense"];


  _submit(){

    _formkey.currentState.save();
    print('$_transactiontype $_amount');
    Transactions transaction=Transactions(transactiontype:_transactiontype,amount: _amount);

    if(widget.transaction==null)
      DataBaseConnection.instance.insertTransaction(transaction);
    else
      DataBaseConnection.instance.updateTransaction(transaction);


    widget.UpdateTransactionList();
    Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:GestureDetector(
        onTap: ()=>FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40,vertical:  80.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(

                  onTap: ()
                  {
                    Navigator.pop(context);
                    },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 40.0,
                    color: Theme.of(context).primaryColor,

                  ),
                ),
                SizedBox(height: 20,),
                Text('Add Transaction',style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),),
                SizedBox(height: 10),
              Form(
                key:_formkey,
                child: Column(
                 children: <Widget>[
                   Padding(
                     padding: const EdgeInsets.symmetric(vertical: 20),
                     child: DropdownButtonFormField(
                       icon:Icon(Icons.arrow_drop_down_circle),
                       iconEnabledColor:Theme.of(context).primaryColor,
                       items:_transactionchoices .map((String priority) {
                       return DropdownMenuItem(value:priority,
                         child: Text(priority,style: TextStyle(
                           color: Colors.black,
                           fontSize: 20.0,

                       ),),);
                       },).toList(),
                       style: TextStyle(
                         fontSize: 20.0,
                       ),
                       decoration: InputDecoration(
                         labelText: 'Transaction Type',
                         labelStyle: TextStyle(fontSize: 18.0),
                         border:OutlineInputBorder(
                             borderRadius: BorderRadius.circular(10.0),
                          )

                       ),

                       validator: (input) => _transactiontype == null
                           ? "Please Select a priority level"
                           : null,
                       onChanged: (value) {
                         setState(() {
                           _transactiontype = value;
                         });
                       },
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.symmetric(vertical: 20),
                     child: TextFormField(
                       style: TextStyle(
                         fontSize: 20.0,
                       ),
                       decoration: InputDecoration(
                           labelText: 'Amount',
                           labelStyle: TextStyle(fontSize: 18.0),
                           border:OutlineInputBorder(
                             borderRadius: BorderRadius.circular(10.0),
                           )

                       ),
                       onSaved: (input)=>_amount=int.parse(input),
                       onChanged: (value){
                         setState(() {
                           _amount=int.tryParse(value);
                         });
                       },


                     ),
                   ),


                   Container(
                     margin: EdgeInsets.symmetric(vertical: 20.0),
                     width: double.infinity,
                     decoration: BoxDecoration(
                       color: Theme.of(context).primaryColor,
                       borderRadius: BorderRadius.circular(10.0),
                     ),
                     child: TextButton(
                     child: Text('Add',  style: TextStyle(
                       fontSize: 20,
                       color: Colors.white,
                     ),),
                       onPressed: _submit,

                     ),

                   )
                 ],
                ),

                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
