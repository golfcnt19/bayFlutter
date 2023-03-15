import 'package:flutter/material.dart';

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page1"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.blue.shade200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset("assets/images/logo.png"),
            MyBox(title: "Box1", backgroundColor: Colors.red),
            MyBox(title: "Box2", backgroundColor: Colors.yellow),
            MyBox(title: "Box3", backgroundColor: Colors.purple),
          ],
        ),
      ),
    );
  }
}

class MyBox extends StatelessWidget {
  const MyBox({
    Key? key,
    required this.title,
    required this.backgroundColor,
  }) : super(key: key);

  final String title;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 50,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
