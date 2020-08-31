import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:meta/meta.dart';
import 'dart:math';

import 'package:pokemon_app/pokemon.dart';

class FlipCard extends StatefulWidget {
  //Card information variables
  final String imageURL;
  final String pokedexNum;
  final String name;
  final List<String> type;
  final Base baseStats;

  const FlipCard({
    this.imageURL,
    @required this.pokedexNum,
    @required this.name,
    @required this.type,
    @required this.baseStats,
  })  : assert(pokedexNum != null),
        assert(name != null),
        assert(type != null),
        assert(baseStats != null);

  @override
  _FlipCardState createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipCard>
    with SingleTickerProviderStateMixin {
  //Animation variables
  AnimationController _animationController;
  Animation<double> _animation;
  AnimationStatus _animationStatus = AnimationStatus.dismissed;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation = Tween<double>(end: 1, begin: 0).animate(_animationController)
      ..addListener(() {
        setState(() {
          //Update state and rebuild
        });
      })
      ..addStatusListener((status) {
        _animationStatus = status;
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }


 // Text _buildTypeButton(String type) {
 //    switch(
 //
 //    )
 // }
 //
 //  //Builds a row filled with all the types that a pokemon has
 // List<Text> _buildTypesRow(List<String> types) {
 //   var text = <Text>[];
 //   types.forEach((type) {
 //     return text.add(_buildTypeButton(type));
 //   });
 //
 //   return text;
 // }

  Card _buildFrontCard() {
    return Card(
      clipBehavior: Clip.antiAlias,
      color: Colors.grey[300],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 0.0,
      child: Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 20.0 / 12.0,
              child: widget.imageURL != null
                  ? Image.network('${widget.imageURL}')
                  : Image.asset('lib/assets/emptyImage.png'),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('#${widget.pokedexNum}'),
                  SizedBox(height: 8.0),
                  Text('${widget.name}'),
                  SizedBox(height: 6.0),
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceAround,
//                    children: _buildTypesRow(widget.type),
//                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card _buildBackCard() {
    return Card(
      clipBehavior: Clip.antiAlias,
      color: Colors.grey[300],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 0.0,
      child: Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Base Stats',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      decoration: TextDecoration.underline,
                      decorationThickness: 1,
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Text('HP: ${widget.baseStats.hP}'),
                  SizedBox(height: 6.0),
                  Text('Attack: ${widget.baseStats.attack}'),
                  SizedBox(height: 6.0),
                  Text('Defense: ${widget.baseStats.defense}'),
                  SizedBox(height: 6.0),
                  Text('Sp. Attack: ${widget.baseStats.spAttack}'),
                  SizedBox(height: 6.0),
                  Text('Sp. Defense: ${widget.baseStats.spDefense}'),
                  SizedBox(height: 6.0),
                  Text('Speed: ${widget.baseStats.speed}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateY(pi * _animation.value),
      child: GestureDetector(
        //Make card clickable
        onTap: () {
          //Dismissed means animation is at the beginning of its range so animation needs to go forward
          if (_animationStatus == AnimationStatus.dismissed) {
            _animationController.forward();
          } else {
            _animationController.reverse();
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[500],
                offset: Offset(4.0, 4.0),
                blurRadius: 15.0,
                spreadRadius: 1.0,
              ),
              BoxShadow(
                color: Colors.white,
                offset: Offset(-4.0, -4.0),
                blurRadius: 15.0,
                spreadRadius: 1.0,
              ),
            ],
          ),
          child: _animation.value <= 0.5 ? _buildFrontCard()
              : Transform(      //Need to rotate back card 180 degrees so content is not backwards
            alignment: Alignment.center,
              transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(pi),
              child: _buildBackCard(),
          ),
        )
      ),
    );
  }
}
