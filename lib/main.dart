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
    final screenWidth = MediaQuery.of(context).size.width;
    final factor = ((screenWidth-100)*1.5) / screenWidth;
    return Scaffold(
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/back.jpg'), fit: BoxFit.cover)
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(alignment: Alignment.center, child: Text('Hello', style: TextStyle(fontSize: 50*factor, color: Colors.white60), textAlign: TextAlign.center,)),
                Align(alignment: Alignment.center, child: RotatedBox(quarterTurns: 1, child: Text(':)', style: TextStyle(fontSize: 50*factor, color: Colors.white60))),),
                Align(alignment: Alignment.center, child: Text('Welcome to the Flut-APP', style: TextStyle(fontSize: 15*factor, color: Colors.white24))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
