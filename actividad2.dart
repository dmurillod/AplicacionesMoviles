import 'dart:convert';
import 'package:http/http.dart' as http;

class Pokemon {
  final String name;
  final int id;
  final int height;
  final int weight;

  Pokemon({
    required this.name,
    required this.id,
    required this.height,
    required this.weight,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      id: json['id'],
      height: json['height'],
      weight: json['weight'],
    );
  }
}

mixin DescriptionDisplayable on Pokemon {
  void displayDescription(String description) {
    print('Description of ${name.toUpperCase()}: $description');
  }
}

class DisplayPokemon extends Pokemon with DescriptionDisplayable {
  final String description;

  DisplayPokemon({
    required String name,
    required int id,
    required int height,
    required int weight,
    required this.description,
  }) : super(name: name, id: id, height: height, weight: weight);

  void displayAllInfo() {
    print('Pokémon Details:');
    print('Name: ${name.toUpperCase()}');
    print('ID: $id');
    print('Height: ${height / 10} meters');
    print('Weight: ${weight / 10} kg');
    displayDescription(description);
  }
}

Future<Pokemon> fetchPokemon(String name) async {
  final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$name'));

  if (response.statusCode == 200) {
    return Pokemon.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Pokémon');
  }
}

// Función asíncrona para obtener la descripción de un Pokémon desde la API
Future<String> fetchPokemonDescription(String name) async {
  final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon-species/$name'));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final descriptions = data['flavor_text_entries'] as List;
    for (var entry in descriptions) {
      if (entry['language']['name'] == 'en') {
        return entry['flavor_text'];
      }
    }
    return 'No description available.';
  } else {
    throw Exception('Failed to load Pokémon description');
  }
}

void main() async {
  try {
    // Ingresar nombre del pokemon
    String pokemonName = 'pikachu'; 
    Pokemon pokemon = await fetchPokemon(pokemonName);
    String description = await fetchPokemonDescription(pokemonName);

    
    DisplayPokemon displayablePokemon = DisplayPokemon(
      name: pokemon.name,
      id: pokemon.id,
      height: pokemon.height,
      weight: pokemon.weight,
      description: description,
    );

    
    displayablePokemon.displayAllInfo();

  } catch (e) {
    print('Error: $e');
  }
}
