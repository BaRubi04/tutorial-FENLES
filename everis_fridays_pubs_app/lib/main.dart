// ignore_for_file: prefer_const_constructors, use_super_parameters, unnecessary_null_comparison
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'dart:convert';
import 'models/pubs.dart';
import 'package:flutter/material.dart';
import 'pub_card.dart';
import 'package:http/http.dart';

void main() => runApp(EverisFridayApp());

class EverisFridayApp extends StatefulWidget {
  const EverisFridayApp({Key? key}) : super(key: key);

  @override
  EverisFridayState createState() => EverisFridayState();
}

class EverisFridayState extends State<EverisFridayApp> {
  final List<Pubs> _listPubs = <Pubs>[];
  late Future<String> futurePubs;
  int maxPrice = 15;

  @override
  void initState() {
    super.initState();
    futurePubs = getPubs(_listPubs);
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Everis Fridays Pub',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Everis Fridays Pub'),
          backgroundColor: Color(0xff9aae04),
        ),
        body: Center(
          child: _buildPubs(), 
        ),
      ),
      );
  }
  Widget _buildPubs() {
	  return FutureBuilder(
	    builder: (context, projectSnap) {
	      if (projectSnap.connectionState == ConnectionState.none ||
	          // ignore: duplicate_ignore
	          // ignore: unnecessary_null_comparison
	          projectSnap.hasData == false) {
	        return Container(child:Text("Ups there is no data or connection"));
	      }
	      return ListView.builder(
	        itemCount: _listPubs.length,
	        itemBuilder: (context, index) {
	          return PubCard(_listPubs[index]);
	        },
	      );
	    },
	    future: futurePubs,
	  );
	}
  Future<String> getPubs(_listPubs) async {
    final Response response = await get(Uri.parse('http://localhost:1337/api/pub/affordable?maxPrice=$maxPrice'));

    if (response.statusCode == 200) {
      List<dynamic> pubsListRaw = jsonDecode(response.body);
      for (var i = 0; i < pubsListRaw.length; i++) {
        _listPubs.add(Pubs.fromJson(pubsListRaw[i]));
      }

      return "Success!";
    } else {
      throw Exception('Failed to load data');
    }
  }



  
}