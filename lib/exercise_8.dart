import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: DataProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const DemoFutureBuilder(),
      ),
    );
  }
}

class DataProvider with ChangeNotifier {
  Future<dynamic> getData() async {
    final client = RetryClient(http.Client());
    try {
      var response = await client.get(
          Uri.parse('https://my.api.mockaroo.com/users.json?key=907b9d70'));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(response.statusCode);
      }
    } catch (e) {
      rethrow;
    } finally {
      client.close();
    }
  }
}

ListView userList(users) {
  return ListView.builder(
    itemCount: users.length,
    itemBuilder: (context, index) {
      return ListTile(
        title: Text(users[index]['first_name']),
        subtitle: Text(users[index]['email']),
      );
    },
  );
}

class DemoFutureBuilder extends StatelessWidget {
  const DemoFutureBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
            future: Provider.of<DataProvider>(context).getData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return userList(snapshot.data);
              }
            }),
      ),
    );
  }
}
