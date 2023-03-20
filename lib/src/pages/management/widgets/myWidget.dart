import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => MyWidgetState();
}

class MyWidgetState extends State<MyWidget> {
  int count = 0;

  add() {
    setState(() {
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(count.toString());
  }
}
