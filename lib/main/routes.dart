import 'package:flutter/material.dart';
import 'login.dart';
import 'settings.dart';
import 'homepage.dart';

final Map<String, WidgetBuilder> routes = {
  Homepage.routeName: (BuildContext context) => const Homepage(),
  LoginScreen.routeName: (BuildContext context) => const LoginScreen(),

  Settings.routeName: (BuildContext context) => const Settings(),
};
