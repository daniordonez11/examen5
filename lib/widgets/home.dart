import 'dart:convert';
import 'package:exa5/model/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class JokeWidget extends StatefulWidget {
  const JokeWidget({super.key});

  @override
  State<JokeWidget> createState() => _JokeWidgetState();
}

class _JokeWidgetState extends State<JokeWidget> {
  Future<List<Joke>> JokeFuture = getJoke();
  @override
  Widget build(BuildContext context) {
        return MaterialApp(
          title: 'Material App',
          home: Scaffold(
            appBar: AppBar(
              title: Text('My Wallet'),
              actions: const [
            IconButton(onPressed: null, icon: Icon(Icons.search)),
            IconButton(onPressed: null, icon: Icon(Icons.more_vert))
          ]
            ),
            body: Center(
              child: Column(
                children: [
                  FutureBuilder(
                    future: JokeFuture, 
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasData) {
                        final Jokes = snapshot.data!;
                        return buildJoke(Jokes);
                      } else {
                        return const Text('No hay datos para mostrar');
                      }
                    }
                    )
                ]
              )
            )
          ),
        );
  }
}

 Future<List<Joke>> getJoke() async {
      var url = Uri.parse("https://v2.jokeJoke.dev/joke/Any?amount=10");
      final response =
          await http.get(url, headers: {"Content-Type": "application/json"});
      final List body = json.decode(response.body);
      return body.map((e) => Joke.fromJson(e)).toList();

    }

  Widget buildJoke(List<Joke> Jokes){
    return Expanded(
      child: ListView.separated(
        itemCount: Jokes.length,
        itemBuilder: (BuildContext context, int index) {
          final Joke = Jokes[index];
          final cat = "${Joke.category}";

          return ListTile(
            title: Text("${Joke.joke}"),
            subtitle: Text(Joke.category),
            trailing: const Icon(Icons.arrow_forward_ios),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            thickness: 2,
          );
        }
      ),
    );
  }
  