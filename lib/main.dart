import 'package:bitcoin_calculator/usdConversion.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter App',
      home: MyHomePage(title: 'Counter App Home Page'),
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
            ElevatedButton(
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                textStyle: TextStyle(
                  fontSize: 20,
                ),
              ),
              child: Text(
                'USD to BTC',
                key: Key('USD'),
              ),
            ),
            ElevatedButton(
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                textStyle: TextStyle(
                  fontSize: 20,
                ),
              ),
              child: Text(
                'BTC to USD',
                key: Key('BTC'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
