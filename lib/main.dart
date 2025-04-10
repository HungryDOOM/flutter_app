import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('LDSW Utilizacion de widgets')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      color: Colors.red,
                      child: Text('Column 1 / Row 1'),
                    )
                  ),
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      color: Colors.blue,
                      child: Text('Column 2 / Row 1')
                    )
                  ),
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      color: Colors.green,
                      child: Text('Column 3 / Row 1')
                    )
                  ),
                ],
              )
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      color: Colors.red,
                      child: Text('Column 1 / Row 2')
                    )
                  ),
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      color: Colors.blue,
                      child: Text('Column 2 / Row 2')
                    )
                  ),
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      color: Colors.green,
                      child: Text('Column 3 / Row 2')
                    )
                  ),
                ],
              )
            ),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 20,
                    bottom: 10,
                    child: Image.asset('assets/images/facebook.png', width: 100)
                  ),
                  Positioned(
                    left: 40,
                    bottom: 20,
                    child: Image.asset('assets/images/instagram.png', width: 100)
                  ),
                  Positioned(
                    left: 60,
                    bottom: 30,
                    child: Image.asset('assets/images/x.png', width: 100)
                  ),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}
