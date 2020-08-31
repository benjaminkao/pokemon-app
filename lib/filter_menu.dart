import 'dart:ui';

import 'package:flutter/material.dart';

final List<String> types = [
  "All",
  "Bug",
  "Dark",
  "Dragon",
  "Electric",
  "Fairy",
  "Fighting",
  "Fire",
  "Flying",
  "Ghost",
  "Grass",
  "Ground",
  "Ice",
  "Normal",
  "Poison",
  "Psychic",
  "Rock",
  "Steel",
  "Water"
];

class FilterMenu extends StatefulWidget {
  final List<String> results;
  final List<String> previousFilter;
  FilterMenu({this.results}) : previousFilter = List.from(results);

  @override
  _FilterMenuState createState() => _FilterMenuState();
}

class _FilterMenuState extends State<FilterMenu> {
  //This is similar to the first tutorial of flutter

  List<String> _results;

  Container _buildFilterRow(String type) {
    final bool saved = _results.contains(type);

    return Container(
      child: GestureDetector(
        child: Row(
          children: <Widget>[
            Icon(
              saved ? Icons.check_box : Icons.check_box_outline_blank,
              color: saved ? Colors.blue : null,
            ),
            Text(
              type,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.black,
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
        onTap: () {
          setState(() {
            if (type == "All") {
              _results.clear();
            } else {
              _results.remove("All");
            }

            if (saved) {
              _results.remove(type);
            } else {
              _results.add(type);
            }
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _results = widget.results;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 0.0, 8.0, 8.0),
        child: SizedBox(
          height: 370,
          width: 300,
          child: Column(
            children: [
              SizedBox(
                height: 320,
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 0,
                  childAspectRatio: 5,
                  children:
                      types.map((String type) => _buildFilterRow(type)).toList(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    child: const Text(
                      "Cancel",
                      style: TextStyle(fontSize: 22),
                    ),
                    onPressed: () => Navigator.pop(context, widget.previousFilter),
                  ),
                  RaisedButton(
                    child: const Text(
                      "Filter",
                      style: TextStyle(fontSize: 22),
                    ),
                    onPressed: _results.length == 0
                        ? null
                        : () => Navigator.pop(context, _results),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
