import 'package:cashflow/screens/Homescreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  int amountfield;

  implementGetstarted() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int cashbalance = amountfield;
    await prefs.setInt('cashbalance', cashbalance);
    Navigator.push(context, MaterialPageRoute(builder:(context){
      return Homescreen();
    }));


  }
GlobalKey<FormState> _formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         body: Container(
            padding: EdgeInsets.symmetric(horizontal: 40,vertical:  80.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[


                SizedBox(height: 10),
                Form(

                  child: Column(
                    children: <Widget>[


                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),

                        child: Form(

                          key:_formkey,
                            child :Column(
                          children:<Widget> [
                            TextFormField(
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                              decoration: InputDecoration(
                                  labelText: 'cash',
                                  labelStyle: TextStyle(fontSize: 18.0),
                                  border:OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  )

                              ),
                              keyboardType: TextInputType.number,
                              validator:(value){
                                if(value==null) {
                                  return null;


                                }amountfield=num.tryParse(value);
                                if(amountfield==null)
                                  {
                                    return "its not a number";
                                  }



                                  return null;
                              },
                              onChanged: (value){
                                setState(() {

                                });
                              },


                            ),
                          ],
                        )
                          )
                      ),


                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: TextButton(
                          child: Text('Get Started',  style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),),
                          onPressed: (){
                            if (_formkey.currentState.validate()) {

                           implementGetstarted();
                            }
                          },


                        ),

                      )
                    ],
                  ),

                )
              ],
            ),
          ),

    );

  }
}