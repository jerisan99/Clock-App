import 'package:flutter/material.dart';

class MyTile extends StatefulWidget {
  const MyTile({super.key});

  @override
  State<MyTile> createState() => _MyTileState();
}

class _MyTileState extends State<MyTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text('hello')),
      color: Colors.blue,
    );
  }
}
