import 'package:flutter/material.dart';

class OwnedPokemonArguments {
  final List<Pokemons> ownedPokemons;

  OwnedPokemonArguments(this.ownedPokemons);
}

class Pokemons {
  final int id;
  final String name;
  final String image;
  Pokemons(this.id, this.name, this.image);
}
