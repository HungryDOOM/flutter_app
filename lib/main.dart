import 'dart:convert';

import 'package:english_words/english_words.dart';
//import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

//All Pokemons
class Pokemon {
  final String name;
  final String imageUrl;

  const Pokemon({required this.name, required this.imageUrl});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      imageUrl: json['sprites']['front_default'],
    );
  }
}

Future<List<String>> fetchPokemonList() async {
  final response = await http.get(
    Uri.parse('https://pokeapi.co/api/v2/Pokemon?limit=20'),
  );

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    return (jsonData['results'] as List).map((pokemon) => pokemon['url'].toString()).toList();
  }
  else {
    throw Exception('Failed to load Pokemons');
  }
}

Future<List<Pokemon>> fetchPokemonDetails() async {
  List<String> urls = await fetchPokemonList();
  List<Pokemon> pokemons = [];

  for (String url in urls) {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      pokemons.add(Pokemon.fromJson(jsonData));
    }
  }
  return pokemons;
}

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
                Align(alignment: Alignment.center, child: ElevatedButton(onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyMainPage()),
                  );
                }, child: Text('Enter'))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyMainPage extends StatelessWidget {
  const MyMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Main')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: FutureBuilder<List<Pokemon>>(
                future: fetchPokemonDetails(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator(),);
                  }
                  else if (snapshot.hasError) {
                    return Center(child:  Text('Error: ${snapshot.error}'));
                  }
                  else if (snapshot.hasData) {
                    final pokemons = snapshot.data!;
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: pokemons.length,
                      itemBuilder: (context, index) {
                        final pokemon = pokemons[index];
                        return ListTile(
                          leading: Image.network(pokemon.imageUrl),
                          title: Text(pokemon.name),
                        );
                      },
                    );
                  }
                  else {
                    return Center(child:  Text('No available data'));
                  }
                },
            )),
          ],
        )
      ),
    );
  }
}