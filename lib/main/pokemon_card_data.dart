import 'package:flutter/material.dart';
class PokemonCardData extends StatelessWidget {
  final String image;
  final String name;
  const PokemonCardData({
    Key? key,
    required this.name,
    required this.image,
  }) : super(key: key);
@override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Image.network(
            image,
            fit: BoxFit.contain,
          ),
        ),
        const Divider(),
        Text(
          "${name[0].toUpperCase()}${name.substring(1)}",
          style: const TextStyle(
            fontSize: 21,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}