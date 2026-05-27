import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'main.dart';
import 'models/pubs.dart';
import 'pub_card.dart';

class AffordablePubsScreen extends StatefulWidget {
  const AffordablePubsScreen({super.key});

  @override
  _AffordablePubsScreenState createState() => _AffordablePubsScreenState();
}

class _AffordablePubsScreenState extends State<AffordablePubsScreen> {
  List<dynamic> pubs = [];
  bool isLoading = true;

  EverisFridayState objEFS = EverisFridayState(); //Como en Java

  int get maxPrice => objEFS.precioMaximo;
  List<Pubs> get _listPubs => objEFS.listaPubs;
  late Future<String> futurePubs;

   

  @override
  void initState() {
    super.initState();
    futurePubs = fetchAffordablePubs(_listPubs);
  }

  Future<String> fetchAffordablePubs(_listPubs) async {
    final response = await http.get(Uri.parse('http://localhost:1337/api/pubs/affordable?maxPrice=$maxPrice'));

    if (response.statusCode == 200) {
      List<dynamic> pubsListRaw = jsonDecode(response.body);
      for (var i = 0; i < pubsListRaw.length; i++) {
        _listPubs.add(Pubs.fromJson(pubsListRaw[i]));
      }
      setState(() {
        isLoading = false;
      });
      return "Success!";
    } else {
      // Error handling
      setState(() {
        isLoading = false;
      });
      print("Failed to load pubs: ${response.statusCode}");
      return "Error";
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Everis Fridays Pub',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Everis Fridays Pub'),
          backgroundColor: Color.fromARGB(255, 157, 0, 0),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: _buildPubs()),

            // Botón para navegar a AffordablePubsScreen
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Builder(
                builder: (context) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => EverisFridayApp()));
                    },
                    child: Text('Show All Pubs'),
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }

    Widget _buildPubs() {
    return FutureBuilder<String>(
      future: futurePubs,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return ListView.builder(
            itemCount: _listPubs.length,
            itemBuilder: (context, index) {
              final pub = _listPubs[index];
              return PubCard(pub);
            },
          );
        }
      },
    );
  }

}



