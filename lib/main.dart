import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        
      ),
      home: const portflix(),
    );
  }
}

class portflix extends StatefulWidget {
  const portflix({Key? key}) : super(key: key);

  @override
  State<portflix> createState() => _portflix();
}

class _portflix extends State<portflix> {

  String descTitle = "", desc = "", descPoster= "", title = "", genre = "", poster = "", year = "";
  TextEditingController movieName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("portFlix")),
      backgroundColor: Colors.grey,
      body: SingleChildScrollView(
        child: Column(
          
          children: [

            const Text(""),

            const Text("portFLix",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),

            const Text(""),

            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a Movie Title'
                
              ),
              controller: movieName,
            ),

            ElevatedButton(onPressed: _search, child: const Text("Search")),

            const Text(""),

            Container(
              alignment: Alignment.center,
              child: Container(
              width: 200,
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    descPoster,
                  ), fit: BoxFit.cover)
                ),
              ),
            ),

            Text(
              descTitle,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 40)
            ),

            Text(
              desc,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)
            ),

          ],
        ),
      )
    );
  }
 
  Future<void> _search() async {
    var name = movieName.text;
    var apiid = "e2d73d5a";
    var url = Uri.parse('https://www.omdbapi.com/?t=$name&apikey=$apiid');
    var response = await http.get(url);
    var rescode = response.statusCode;

    if (rescode == 200) {
      var jsonData = response.body;
      var parsedJson = json.decode(jsonData);

      title = parsedJson['Title'];
      genre = parsedJson['Genre'];
      year = parsedJson['Year'];
      poster = parsedJson['Poster'];
      
      setState((){
       
        descTitle = title;
        desc = "$genre / $year";
        descPoster = poster;

      });

      print(parsedJson);
    }

  }
  
}