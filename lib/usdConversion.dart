import 'package:flutter/material.dart';

class USDConversion extends StatefulWidget {
  @override
  String selection = '';
  USDConversion({this.selection});

  _USDConversionState createState() => _USDConversionState();
}

class _USDConversionState extends State<USDConversion> {
  final textController = TextEditingController();
  bool button = false;
  void initState() {
    super.initState();
    textController.addListener(() {
      setState(() {
        button = textController.text.isNotEmpty;
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Color(0xFF4C748B)),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              key: Key('back-button'),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.transparent),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('How many ${widget.selection} would you like to convert?'),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              controller: textController,
              key: Key('input-field'),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {}, key: Key('calc'), child: Text('Calculate')),
          Text('Conversion Result: ')
        ],
      ),
    );
  }
}
