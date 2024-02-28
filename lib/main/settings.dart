import 'package:flutter/material.dart';
import 'components/primary_button.dart';
import 'index.dart';
import 'package:pokemon_api/main/dashboard_argument.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Settings extends StatefulWidget {
  static const String routeName = "settings";
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  var args = ScreenArguments("", "");
  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
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
          Text(args.displayName),
          Text(args.email),
          PrimaryButton(
              text: "Logout", iconData: Icons.logout, onPressed: logout)
        ],
      )),
    );
  }

  void logout() {
    FirebaseAuth.instance.signOut().then((value) => {
          GoogleSignIn().signOut().then((value) =>
              {Navigator.pushReplacementNamed(context, Index.routeName)})
        });
  }
}
