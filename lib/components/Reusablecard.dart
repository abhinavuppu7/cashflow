import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailCard extends StatelessWidget {
  DetailCard(
      {@required this.label, @required this.value, @required this.colour});
  final String label;
  final int value;
  final Color colour;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      margin: EdgeInsets.all(15.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: colour,
      child: Column(
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            "${value}",
            style: TextStyle(
                color: Colors.white, fontSize: 70, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
