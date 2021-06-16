import 'package:cashflow/helpers/database_connection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cashflow/datamodels/tranasactionmodel.dart';
import 'package:intl/intl.dart';

class AddTransaction extends StatefulWidget {
  final Function UpdateTransactionList;
  final Function UpdateAmount;

  final Transactions transaction;
  AddTransaction(
      {this.UpdateTransactionList, this.UpdateAmount, this.transaction});
  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  @override
  void initState() {
    _dateController.text = _dateformatter.format(_date);

    if (widget.transaction != null) {
      _id = widget.transaction.id;
      _transactiontype = widget.transaction.transactiontype;
      _amount = widget.transaction.amount;
      _description = widget.transaction.description;
      _date = widget.transaction.date;
      _transactioncategory = widget.transaction.category;
    }
  }

  final _formkey = GlobalKey<FormState>();
  String _transactiontype = '';
  String _transactioncategory = '';
  int _amount = 0;
  int _id;
  String _description = '';
  DateTime _date = DateTime.now();
  TextEditingController _dateController = TextEditingController();
  final List<String> _transactionchoices = ["Income", "Expense"];
  final List<String> _transactioncategories = [
    'sports',
    'food',
    'grocery',
    'shopping',
    'travel',
    'fitness',
    'bills',
    'housing',
    'health',
  ];
  final DateFormat _dateformatter = DateFormat('MMM dd,yyyy');
  _handleDatepicker() async {
    final DateTime date = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (date != null && date != _date) {
      setState(() {
        _date = date;
      });
    }
    _dateController.text = _dateformatter.format(date);
  }

  _submit() async {
    _formkey.currentState.save();
    print('$_transactiontype $_amount $_transactioncategory');
    Transactions transaction = Transactions(
        transactiontype: _transactiontype,
        amount: _amount,
        description: _description,
        category: _transactioncategory,
        date: _date);

    if (widget.transaction == null)
      await DataBaseConnection.instance.insertTransaction(transaction);
    else {
      transaction.id = _id;
      await DataBaseConnection.instance.updateTransaction(transaction);
      print(
          '$_transactiontype $_amount $_transactioncategory $_date $_description');
    }

    widget.UpdateTransactionList();
    widget.UpdateAmount();
    Navigator.pop(context);
  }

  _Delete() async {
    await DataBaseConnection.instance.deleteTransaction(widget.transaction.id);
    widget.UpdateTransactionList();
    widget.UpdateAmount();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 80.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 40.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  widget.transaction == null
                      ? 'Add Transaction'
                      : 'Update Transaction',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 37,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Form(
                  key: _formkey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: DropdownButtonFormField(
                          icon: Icon(Icons.arrow_drop_down_circle),
                          iconEnabledColor: Colors.greenAccent,
                          items: _transactionchoices.map(
                            (String priority) {
                              return DropdownMenuItem(
                                value: priority,
                                child: Text(
                                  priority,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                          value: widget.transaction != null
                              ? _transactiontype
                              : null,
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                          decoration: InputDecoration(
                              labelText: 'Transaction Type',
                              labelStyle: TextStyle(fontSize: 18.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              )),
                          validator: (input) => _transactiontype == null
                              ? "Please Select a transaction type"
                              : null,
                          onChanged: (value) {
                            setState(() {
                              _transactiontype = value;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: DropdownButtonFormField(
                          icon: Icon(Icons.arrow_drop_down_circle),
                          iconEnabledColor: Colors.greenAccent,
                          items: _transactioncategories.map(
                            (String priority) {
                              return DropdownMenuItem(
                                value: priority,
                                child: Text(
                                  priority,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                          value: widget.transaction != null
                              ? _transactioncategory
                              : null,
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                          decoration: InputDecoration(
                              labelText: 'Category',
                              labelStyle: TextStyle(fontSize: 18.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              )),
                          validator: (input) => _transactiontype == null
                              ? "Please Select a category"
                              : null,
                          onChanged: (value) {
                            setState(() {
                              _transactioncategory = value;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: TextFormField(
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                          decoration: InputDecoration(
                              labelText: 'Amount',
                              labelStyle: TextStyle(fontSize: 18.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              )),
                          onSaved: (input) => _amount = int.parse(input),
                          onChanged: (value) {
                            setState(() {
                              _amount = int.tryParse(value);
                            });
                          },
                          initialValue: _amount.toString(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: TextFormField(
                          onTap: _handleDatepicker,
                          controller: _dateController,
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                          // initialValue: _dateController.value.toString(),
                          decoration: InputDecoration(
                              labelText: 'date',
                              labelStyle: TextStyle(fontSize: 18.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: TextFormField(
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                          decoration: InputDecoration(
                              labelText: 'description',
                              labelStyle: TextStyle(fontSize: 18.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              )),
                          validator: (input) => _transactiontype == null
                              ? "Please Enter the description"
                              : null,
                          onChanged: (value) {
                            setState(() {
                              _description = value;
                            });
                          },
                          initialValue: _description,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 15.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: TextButton(
                          child: Text(
                            widget.transaction == null ? 'Add' : 'Update',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: _submit,
                        ),
                      ),
                      widget.transaction != null
                          ? Container(
                              margin: EdgeInsets.symmetric(vertical: 15.0),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: TextButton(
                                child: Text(
                                  'Delete',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: _Delete,
                              ),
                            )
                          : SizedBox.shrink()
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
