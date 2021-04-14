import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class Homescreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xFFf8f5f1),
    body: Container(
     margin: EdgeInsets.only(top: 20),
    child: Column(



      children: <Widget>[
        Text('Cash',
          style: TextStyle(
            fontSize: 20,

          ),

        ),
       SizedBox(height: 10,),
        Container(
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color:Colors.white,

          ),

          child:Padding(
            
            padding: const EdgeInsets.all(40.0),
            child: Row(
             
              
              children: <Widget>[
                Icon(Icons.credit_card_outlined
                ),
                SizedBox(width:50),
                Text('Kotak Mahindra Bank'),
                SizedBox(width:50),

                Text('2,000')
              ],
            ),
          ),

        ),
        SizedBox(height: 20,),
        Text('Transactions',
          style: TextStyle(
            fontSize: 20,

          ),

        ),
        //transctions
        SizedBox(height: 10,),
        Container(
          height: 100,
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(30),
             color: Colors.white,
           ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(

              children: <Widget>[
               CircleAvatar(
                   child: Icon(FontAwesomeIcons.shoppingBasket)),
                SizedBox(width:100),
                   Text('milkshake',

                   style:TextStyle(

                   ),),
                SizedBox(width:100),
                   Text('-50',style: TextStyle(
                     color: Colors.red,
                   ),)




              ],


            ),
          ),

        ),
        SizedBox(height: 10,),
        Container(
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(

              children: <Widget>[
                CircleAvatar(backgroundColor: Colors.amberAccent,
                    child: Icon(Icons.shopping_cart_rounded)),
                SizedBox(width:100),
                Text('dress',

                  style:TextStyle(

                  ),),
                SizedBox(width:125),
                Text('-300',style: TextStyle(
                  color: Colors.red,
                ),)




              ],


            ),
          ),

        ),
        SizedBox(height: 10,),
        Container(
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(

              children: <Widget>[
                CircleAvatar(backgroundColor: Colors.greenAccent,
                    child: Icon(Icons.food_bank_sharp)),
                SizedBox(width:100),
                Text('restaurant',

                  style:TextStyle(

                  ),),
                SizedBox(width:100),
                Text('-50',style: TextStyle(
                  color: Colors.red,
                ),)




              ],


            ),
          ),

        ),
        SizedBox(height: 10,),
        Container(
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(

              children: <Widget>[
                CircleAvatar(backgroundColor: Colors.red,
                    child: Icon(FontAwesomeIcons.car
                    )),
                SizedBox(width:100),
                Text('school',

                  style:TextStyle(

                  ),),
                SizedBox(width:120),
                Text('-50',style: TextStyle(
                  color: Colors.red,
                ),)




              ],


            ),
          ),

        ),
    SizedBox(height:80),
    FloatingActionButton(
     child: Icon(Icons.add),

    ),
      ],
    ),

    ),
    );
  }
}
