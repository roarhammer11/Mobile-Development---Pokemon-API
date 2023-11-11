// ignore_for_file: avoid_unnecessary_containers

import 'dart:convert';

import 'package:flutter/material.dart';
import 'settings.dart';
import 'package:http/http.dart' as http;

class Homepage extends StatefulWidget {
  const Homepage({super.key});
  static const String routeName = "homepage";
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final myController = TextEditingController();
  List<Widget> list = [];
  late Future instanceOfApi;
  @override
  void initState() {
    super.initState();
    instanceOfApi = callApi();
    // print(instanceOfApi);
  }

  @override
  Widget build(BuildContext context) {
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
              onPressed: callApi,
              child: const Padding(
                padding: EdgeInsets.fromLTRB(100, 0, 100, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [Icon(Icons.dashboard), Text("Dashboard")],
                ), //Container
              ),
            ),
            ElevatedButton(
              onPressed: catchPokemon,
              child: const Padding(
                padding: EdgeInsets.fromLTRB(100, 0, 100, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [Icon(Icons.catching_pokemon), Text("Catch")],
                ), //Container
              ),
            ),
            ElevatedButton(
                onPressed: inventory,
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(100, 0, 100, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [Icon(Icons.shopping_bag), Text("Inventory")],
                  ), //Container
                ))
          ],
        ),
      ),
    );
  }

  // @override
  // void afterFirstLayout(BuildContext context) async {
  //   await callApi();
  //   // print(api["results"][0]);
  // }

  FutureBuilder createDashbord() {
    return FutureBuilder(
        future: instanceOfApi,
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            print(snapshot.data!);
            return ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return ElevatedButton(
                    onPressed: null,
                    child: Text(snapshot.data["results"][index]["name"] ??
                        "got null "));
              },
            );
          }
          return const Text("hehe");
        });
    // return FutureBuilder(
    //   future: instanceOfApi,
    //   builder: (context, snapshot) => ListView.builder(
    //     itemBuilder: (BuildContext ctxt, int index) =>
    //         build(ctxt, index)
    //   ),
    // );
    // return ListView.builder(
    //   itemCount: api["count"],
    //   itemBuilder: (BuildContext ctx, int index) => buildBody(ctx, index, list),
    // );
  }

  // Widget buildBody(
  //   BuildContext ctxt,
  //   int index,
  // ) {
  //   return Container(child: ctxt[index]);
  // }

  void dashboard() {}
  void catchPokemon() {}
  void inventory() {}
  void settings() {
    Navigator.pushNamed(context, Settings.routeName);
  }

  Future callApi() async {
    Map<String, dynamic> api = {};
    final response =
        await http.get(Uri.parse("https://pokeapi.co/api/v2/pokemon/"));
    api = jsonDecode(response.body);
    await createWidget(api);
    // print(api);
    return api;
  }

  createWidget(api) async {
    for (int i = 0; i < 20; i++) {
      String name = await api["results"][i]["name"];
      print(name);
      list.add(Container(
        child: ElevatedButton(
          onPressed: null,
          child: Padding(
              padding: const EdgeInsets.fromLTRB(100, 0, 100, 0),
              child: Text(name)),
        ),
      ));
    }
  }
}
