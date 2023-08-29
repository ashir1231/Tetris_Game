import 'package:flutter/material.dart';

class Pixel extends StatelessWidget {
  var color;

   Pixel({Key? key, required this.color,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4)
      ),
      margin: EdgeInsets.all(1),

    );
  }
}
