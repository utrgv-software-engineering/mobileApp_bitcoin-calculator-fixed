import 'package:bitcoin_calculator/calc_tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'config/globals.dart';

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
  String pesos = '';
  String converted = '';

  Future<String> conversion;

  @override
  void initState() {
    super.initState();
    textController.addListener(() {
      setState(() {
        button = textController.text.isNotEmpty;
      });
    });
    conversion = CalculationTools.fetchConversion(httpClient);
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

  TextInputFormatter allowDigitsAndDecimal({int decimalRange}) =>
      FilteringTextInputFormatter.allow(
          RegExp(r'^\d*\.?\d{0,' + (decimalRange?.toString() ?? '') + r'}'));

  void setst8() {
    setState(() {
      if (widget.selection == "Dollars") {
        result = CalculationTools.USDtoBTC(pesos);
      } else if (widget.selection == "Bitcoin") {
        result = CalculationTools.BCTtoUSD(pesos, converted);
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
        iconTheme: IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            key: Key('back-button'),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'How many ${widget.selection} would you like to convert?',
            style: TextStyle(fontSize: 18),
            key: Key('Prompt'),
          ),
          SizedBox(height: 5),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
            child: TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [],
              key: Key('input-field'),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color(0xFF4C748B)),
                ),
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
                      if (double.parse(pesos) < 0.01) {
                        throw ArgumentError(
                            'Value cannot be less then or equal to 0');
                      } else {
                        setst8();
                      }
                    }
                  : null,
              key: Key('calc'),
              style: ButtonStyle(),
              child: Text('Calculate', style: TextStyle(fontSize: 15))),
          SizedBox(height: 25),
          FutureBuilder<String>(
            key: Key('API'),
            future: conversion,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                converted = snapshot.data;
                return Text(converted);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          )
          // Text(
          //   'Conversion Result: ' + result,
          //   style: TextStyle(fontSize: 18),
          //   key: Key('converted'),
          // )
        ],
      ),
    );
  }
}
