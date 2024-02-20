// ignore_for_file: avoid_unnecessary_containers, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter/material.dart';
import 'settings.dart';
import 'package:http/http.dart' as http;
// ignore: implementation_imports
import 'package:http/src/response.dart';
import 'package:pokemon_api/main/dashboard_argument.dart';

class Homepage extends StatefulWidget {
  const Homepage({
    super.key,
  });
  static const String routeName = "homepage";

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final myController = TextEditingController();
  late Future instanceOfApi;
  late ScreenArguments args;
  Map<String, dynamic> api = {};
  @override
  void initState() {
    super.initState();
    instanceOfApi = callApi("https://pokeapi.co/api/v2/pokemon/");
    // print(instanceOfApi);
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Homepage"),
        actions: [
          IconButton(onPressed: settings, icon: const Icon(Icons.settings))
        ],
      ),
      body: createDashbord(),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ElevatedButton(
              onPressed: dashboard,
              child: const Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [Icon(Icons.dashboard), Text("Dashboard")],
                ), //Container
              ),
            ),
            ElevatedButton(
              onPressed: catchPokemon,
              child: const Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [Icon(Icons.catching_pokemon), Text("Catch")],
                ), //Container
              ),
            ),
            ElevatedButton(
                onPressed: releasePokemon,
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [Icon(Icons.cancel), Text("Release")],
                  ), //Container
                ))
          ],
        ),
      ),
    );
  }

  Builder createDashbord() {
    return Builder(
      builder: (BuildContext context) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(child: futureBuilder()),
              Expanded(flex: 0, child: moveApi())
            ]);
      },
    );
  }

  FutureBuilder futureBuilder() {
    return FutureBuilder(
        future: instanceOfApi,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Padding(
                padding: EdgeInsets.all(250),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [CircularProgressIndicator()]));
          }
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo),
                    onPressed: () {
                      _showSimpleModalDialog(
                          context, snapshot.data["results"][index]);
                    },
                    // child: Text(snapshot.data["results"][index]["name"] ??
                    //     "got null "));
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(100, 20, 100, 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(snapshot.data["results"][index]["name"])
                        ],
                      ), //Container
                    ));
              },
            );
          }
          return ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) {
              return ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
                  onPressed: () {
                    _showSimpleModalDialog(
                        context, snapshot.data["results"][index]);
                  },
                  // child: Text(snapshot.data["results"][index]["name"] ??
                  //     "got null "));
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(100, 20, 100, 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [Text(snapshot.data["results"][index]["name"])],
                    ), //Container
                  ));
            },
          );
        });
  }

  Container moveApi() {
    return Container(
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      ElevatedButton(
        onPressed: previousApi,
        style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
        child: const Text("Previous"),
      ),
      ElevatedButton(
          onPressed: nextApi,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
          child: const Text("Next"))
    ]));
  }

  void previousApi() async {
    if (api["previous"] != null) {
      instanceOfApi = callApi(api["previous"]);
      setState(() {
        createDashbord();
      });
      build(context);
    }
  }

  void nextApi() async {
    if (api["next"] != null) {
      instanceOfApi = callApi(api["next"]);
      setState(() {
        createDashbord();
      });
      build(context);
    }
  }

  void dashboard() {}
  void catchPokemon() {}
  void releasePokemon() {}
  void settings() {
    Navigator.pushNamed(context, Settings.routeName,
        arguments: ScreenArguments(args.displayName, args.email));
  }

  Future callApi(domain) async {
    Response response = await http.get(Uri.parse(domain));
    api = jsonDecode(response.body);
    return api;
  }

  _showSimpleModalDialog(context, api) async {
    Response response = await http
        .get(Uri.parse("https://pokeapi.co/api/v2/pokemon/" + api["name"]));
    Map<String, dynamic> specificApi = jsonDecode(response.body);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 300, maxWidth: 125),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
                      specificApi["sprites"]["front_default"],
                      frameBuilder: (BuildContext context, Widget child,
                          int? frame, bool? wasSynchronouslyLoaded) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: child,
                        );
                      },
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        return Center(child: child);
                      },
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("id#: " + specificApi["id"].toString()),
                        Text("Name: " + specificApi["name"]),
                        Text("Base Experience: " +
                            specificApi["base_experience"].toString()),
                        Text("Height: " + specificApi["height"].toString()),
                        Text("Weight: " + specificApi["weight"].toString()),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
