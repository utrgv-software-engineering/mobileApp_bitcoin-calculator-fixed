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
  //bool check = null;
  String pesos = '';

  // void checkF(){
  //   if(widget.selection == "Dollars"){
  //     check
  //   }
  // }

  void initState() {
    super.initState();
    textController.addListener(() {
      setState(() {
        button = textController.text.isNotEmpty;
      });
    });
  }

  bool _validateTextField(String value) {
    setState(() {
      if (value.isEmpty) {
        return false;
      }

      double currency = double.tryParse(value);
      if (currency != null && currency > 0) {
        return true;
      } else {
        throw ('Enter a value greater than 0');
      }
    });
  }

  TextInputFormatter allowDigitsAndDecimal({int decimalRange}) =>
      FilteringTextInputFormatter.allow(
          RegExp(r'^\d*\.?\d{0,' + (decimalRange?.toString() ?? '') + r'}'));

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
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [],
              key: Key('input-field'),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  if (value.isEmpty) {
                    button = false;
                  } else {
                    button = _validateTextField(value);

                    pesos = value;
                  }
                });
              },
            ),
          ),
          ElevatedButton(
              onPressed: button
                  ? () {
                      setst8();
                    }
                  : null,
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
