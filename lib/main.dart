import 'package:bitcoin_calculator/usdConversion.dart';
import 'package:flutter/material.dart';
import 'calc_tools.dart';
//import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bitcoin Converter',
      home: MyHomePage(title: 'Bitcoin Converter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String selection = '';
  Future<String> conversion;

  @override
  void initState() {
    super.initState();
    conversion = CalculationTools.fetchConversion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 75,
              width: 250,
              child: ElevatedButton(
                key: Key('topButton'),
                onPressed: () {
                  selection = 'Dollars';
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => USDConversion(
                                selection: selection,
                              )));
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: TextStyle(
                    fontSize: 20,
                  ),
                ),
                child: Text(
                  'USD to BTC',
                  style: TextStyle(fontSize: 30),
                  key: Key('USD'),
                ),
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              height: 75,
              width: 250,
              child: ElevatedButton(
                key: Key('botButton'),
                onPressed: () {
                  selection = 'Bitcoin';
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => USDConversion(
                                selection: selection,
                              )));
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: TextStyle(
                    fontSize: 20,
                  ),
                ),
                child: Text(
                  'BTC to USD',
                  style: TextStyle(fontSize: 30),
                  key: Key('BTC'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
