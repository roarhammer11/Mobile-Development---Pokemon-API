import 'package:flutter/material.dart';
import 'package:pokemon_api/main/pokemon_card.dart';
import 'owned_pokemon_argument.dart';

class OwnedPokemons extends StatefulWidget {
  static const String routeName = "owned_pokemons";

  const OwnedPokemons({super.key});

  @override
  State<OwnedPokemons> createState() => _OwnedPokemonsState();
}

class _OwnedPokemonsState extends State<OwnedPokemons> {
  var pokemons = OwnedPokemonArguments([]);

  @override
  Widget build(BuildContext context) {
    pokemons =
        ModalRoute.of(context)!.settings.arguments as OwnedPokemonArguments;
    print(pokemons);
    final width = MediaQuery.of(context).size.width;
    final crossAxisCount = (width > 1000)
        ? 5
        : (width > 700)
            ? 4
            : (width > 450)
                ? 3
                : 2;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Owned Pokemons"),
        ),
        body: GridView.count(
          padding: const EdgeInsets.all(7),
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          semanticChildCount: 250,
          childAspectRatio: 200 / 244,
          physics: const BouncingScrollPhysics(),
          children: pokemons.ownedPokemons
              .map(
                (pokemon) => PokemonCard(
                  id: pokemon.id,
                  name: pokemon.name,
                  image: pokemon.image,
                ),
              )
              .toList(),
        ));
  }
  // return Scaffold(
  //     appBar: AppBar(
  //       title: const Text("Owned Pokemons"),
  //     ),
  //     body: Text(args.ownedPokemons.toString()));
}
