import 'package:flutter/material.dart';
import 'components/primary_button.dart';
import 'index.dart';

class Settings extends StatefulWidget {
  static const String routeName = "settings";
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Center(
          child: Column(
        children: [
          const SizedBox(
            height: 30.0,
          ),
          PrimaryButton(
              text: "Logout", iconData: Icons.logout, onPressed: logout)
        ],
      )),
    );
  }

  void logout() {
    Navigator.pushReplacementNamed(context, Index.routeName);

  }
}
