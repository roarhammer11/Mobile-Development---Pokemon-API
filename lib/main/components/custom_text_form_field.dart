import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final IconData iconData;
  final TextInputType textInputType;
  final TextEditingController controller;

  const CustomTextFormField(
      {super.key, required this.labelText,
      required this.hintText,
      required this.iconData,
      required this.textInputType,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        keyboardType: textInputType,
        controller: controller,
        decoration: InputDecoration(
            prefixIcon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Icon(iconData),
            ),
            labelText: labelText,
            hintText: hintText,
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0)))));
  }
}
