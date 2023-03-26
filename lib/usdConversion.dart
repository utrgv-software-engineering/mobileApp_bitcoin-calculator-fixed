import 'package:bitcoin_calculator/calc_tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class USDConversion extends StatefulWidget {
  @override
  String selection = '';
  USDConversion({this.selection});

  _USDConversionState createState() => _USDConversionState();
}

class _USDConversionState extends State<USDConversion> {
  final textController = TextEditingController();
  bool button = false;
  int userInput = 0;
  String result = '';

  double pesos = 0;

  void initState() {
    super.initState();
    textController.addListener(() {
      setState(() {
        button = textController.text.isNotEmpty;
      });
    });
  }

  bool _validateTextField(String value) {
    if (value.isEmpty) {
      return false;
    }
    double currency = double.tryParse(value);
    if (currency != null && currency > 0) {
      return true;
    }
    return false;
  }

  void setst8() {
    setState(() {
      if (widget.selection == "Dollars") {
        result = CalculationTools.USDtoBTC(pesos);
      } else if (widget.selection == "Bitcoin") {
        result = CalculationTools.BCTtoUSD(pesos);
      }
      return result;
    });
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
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
          Text(
            'How many ${widget.selection} would you like to convert?',
            key: Key('Prompt'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              keyboardType: TextInputType.number,
              key: Key('input-field'),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                button = _validateTextField(value);
                var temp = int.parse(value);
                pesos = temp.toDouble();
                //print(pesos);
              },
            ),
          ),
          ElevatedButton(
              onPressed: () {
                setst8();
              },
              key: Key('calc'),
              child: Text('Calculate')),
          Text(
            'Conversion Result: ' + result,
            key: Key('converted'),
          )
        ],
      ),
    );
  }
}
