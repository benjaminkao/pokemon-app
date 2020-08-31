import 'package:flutter/material.dart';

import 'package:pokemon_app/flip_card.dart';
import 'package:pokemon_app/pokemon.dart';
import 'package:pokemon_app/filter_menu.dart';

class Pokedex extends StatefulWidget {
  List<Pokemon> pokedex;
  List<String> types = ["All"];

  Pokedex({this.pokedex});

  @override
  _PokedexState createState() => _PokedexState();
}

class _PokedexState extends State<Pokedex> {
  List<Pokemon> _loadPokemon(List<String> types) {
    if (types.contains("All")) {
      //If type contains all, return all
      return widget.pokedex;
    } else {
      return widget.pokedex.where((Pokemon p) {
        return p.compareTypes(types);
      }).toList();
    }
  }

  _showFilterMenu(BuildContext context) async {
    final List<String> results = await Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, _, __) => FilterMenu(
          //Send current filtered types
          results: widget.types,
        ),
        opaque: false,
        barrierDismissible: true,
      ),
    );

    //After filter menu is closed and results are gotten, clear types list and add new types to filter
    setState(() {
      //Remove all types that aren't in results
      if(results != null) {
        widget.types = results;
      }
    });

  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: const Text('Pokemon App'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.tune),
              onPressed: () {
                //Open up filter drawer
                _showFilterMenu(context);
              },
            ),
          ],
        ),
        body: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(16.0),
          childAspectRatio: 4.0 / 5.0,
          children: _loadPokemon(widget.types)
              .map((pokemon) => Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: FlipCard(
                      imageURL: pokemon.imageURL,
                      pokedexNum: pokemon.pokedexNum,
                      name: pokemon.name.english,
                      type: pokemon.type,
                      baseStats: pokemon.base,
                    ),
                  ))
              .toList(),
        ));
  }
}
