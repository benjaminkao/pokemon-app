import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pokemon_app/pokemon.dart';
import 'package:pokemon_app/pokedex.dart';

//URL: https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json
//https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/pokedex.json

Future<List<Pokemon>> fetchPokedexData() async {
  final response = await http.get(
      'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/pokedex.json');

  if (response.statusCode == 200) {
    return parsePokemon(response.body);
  } else {
    throw Exception('Failed to load Pokedex data');
  }
}

List<Pokemon> parsePokemon(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Pokemon>((json) => Pokemon.fromJson(json)).toList();
}

class PokemonApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FutureBuilder<List<Pokemon>>(
          future: fetchPokedexData(),
          builder: (context, snapshot) {
            //Until future snapshat has data, show a circular progress indicator
            if (snapshot.hasData) {
              //Create the pokedex and send over the data
              return Pokedex(pokedex: snapshot.data);
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
        theme: ThemeData(
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Colors.black,
                displayColor: Colors.black,
              ),
        ));
  }
}
