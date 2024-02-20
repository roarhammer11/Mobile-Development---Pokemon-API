import 'package:flutter/material.dart';
import 'index.dart';
import 'settings.dart';
import 'homepage.dart';

final Map<String, WidgetBuilder> routes = {
  Homepage.routeName: (BuildContext context) => const Homepage(),
  Index.routeName: (BuildContext context) => const Index(),
  Settings.routeName: (BuildContext context) => const Settings(),
};
