


class Transactions{
  static  String table="transactions";
  int id;

  String transactiontype;

  int amount;

  Transactions ({this.amount,this.transactiontype});
 Transactions.WithID({this.id,this.amount,this.transactiontype});

 factory Transactions.fromMap(Map<String,dynamic>map){
   return Transactions.WithID(
     id: map['id'],
     transactiontype: map['transactiontype'],
     amount: map['amount'],
   );

  }

//   Transactions.fromMap(Map<String,dynamic>map){
//    id=map[DataBaseConnection.COLUMN_ID];
//    amount=map[DataBaseConnection.COLUMN_AMOUNT];
// transactiontype=map[DataBaseConnection.COLUMN_TRANSACTIONTYPE];
//
//   }
  Map<String, dynamic> toMap() {
    final map=Map<String,dynamic>();
    if(id!=null)
      map['id']=id;

    map['transactiontype']=transactiontype;
    map['amount']=amount;
    return map;
  }



}

