final String imageURLBase = 'https://www.serebii.net/pokemongo/pokemon/';
class Pokemon {
  String pokedexNum;
  Name name;
  List<String> type;
  Base base;
  String imageURL;

  Pokemon({this.pokedexNum, this.name, this.type, this.base});

  Pokemon.fromJson(Map<String, dynamic> json) {
    pokedexNum = _formatPokemonNum(json['id']);
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    type = json['type'].cast<String>();
    base = json['base'] != null ? new Base.fromJson(json['base']) : null;
    imageURL = imageURLBase + _formatPokemonNum(json['id']) + '.png';
  }


  String _formatPokemonNum(dynamic num) {
    String result = num.toString();

    while(result.length < 3) {
      result = "0" + result;
    }

    return result;
  }

  //This function is used to compare types to filter out pokemon, used in Pokedex._loadPokedex()
  bool compareTypes(List<String> types) {
    for(int i = 0; i < types.length; i++) {
      for(int j = 0; j < this.type.length; j++) {
        if(types[i].toLowerCase() == this.type[j].toLowerCase()) {
          return true;
        }
      }
    }
    return false;
  }

}

class Name {
  String english;
  String japanese;
  String chinese;
  String french;

  Name({this.english, this.japanese, this.chinese, this.french});

  Name.fromJson(Map<String, dynamic> json) {
    english = json['english'];
    japanese = json['japanese'];
    chinese = json['chinese'];
    french = json['french'];
  }

}

class Base {
  int hP;
  int attack;
  int defense;
  int spAttack;
  int spDefense;
  int speed;

  Base(
      {this.hP,
        this.attack,
        this.defense,
        this.spAttack,
        this.spDefense,
        this.speed});

  Base.fromJson(Map<String, dynamic> json) {
    hP = json['HP'];
    attack = json['Attack'];
    defense = json['Defense'];
    spAttack = json['Sp. Attack'];
    spDefense = json['Sp. Defense'];
    speed = json['Speed'];
  }
}