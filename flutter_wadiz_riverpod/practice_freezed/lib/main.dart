import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:practice_freezed/basic_model.dart';

String jsonUrl = "https://jsonplaceholder.typicode.com/users";

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: const Center(
          child: Text('Hello World!'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final response = await http.get(Uri.parse(jsonUrl));
            if (response.statusCode == 200) {
              List<dynamic> jsonResp = jsonDecode(response.body);
              print(jsonResp);
              for (var element in jsonResp) {
                final jsonData = element as Map<String, dynamic>;
                final user = BasicUser.fromJson(jsonData);
                print(user);
              }
            }
          },
        ),
      ),
    );
  }
}
