import 'package:flutter/material.dart';

class USDConversion extends StatefulWidget {
  @override
  String selection = '';
  USDConversion({this.selection});

  _USDConversionState createState() => _USDConversionState();
}

class _USDConversionState extends State<USDConversion> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            widget.selection,
            key: Key('newPage'),
          ),
        ],
      ),
    );
  }
}
