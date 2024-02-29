import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_api/main/pokemon_card_background.dart';
import 'package:pokemon_api/main/pokemon_card_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;

class PokemonCard extends StatelessWidget {
  final int id;
  final String name;
  final String image;
  PokemonCard({
    Key? key,
    required this.id,
    required this.name,
    required this.image,
  }) : super(key: key);

  BoxDecoration getContainerDecoration() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(
          color: Colors.grey.withOpacity(0.24),
          width: 1,
        ),
      );
  final db = firestore.FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: releasePokemon,
      child: Container(
        padding: const EdgeInsets.all(7),
        decoration: getContainerDecoration(),
        child: Stack(
          children: [
            PokemonCardBackground(id: id),
            PokemonCardData(name: name, image: image),
          ],
        ),
      ),
    );
  }

  void releasePokemon() async {
    await db
        .collection("ownedPokemons")
        .where("userId", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .where("pokemonId", isEqualTo: id)
        .get()
        .then((value) async => await db.runTransaction((transaction) async =>
            transaction.delete(value.docs[0].reference)));
    
  }
}
