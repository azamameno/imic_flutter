import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  final Random random = Random();
  var colors = Colors.primaries;

  String outputMessage = '';
  final textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: _counter % 2 == 0
          ? colors[random.nextInt(colors.length)]
          : Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _incrementCounter,
              child: const Text('Phần 1 - Đổi màu nền'),
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: 200,
              child: TextField(
                controller: textFieldController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _checkPrimeNumber,
              child: const Text('Phần 2 - Kiểm tra số nguyên tố'),
            ),
            const SizedBox(height: 10),
            Text(outputMessage),
          ],
        ),
      ),
    );
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _checkPrimeNumber() {
    String text = textFieldController.text;
    setState(() {
      int? number = int.tryParse(text.trim());
      if (number == null) {
        outputMessage = '$text không phải là số';
      }

      bool isPrimeNumber = _isPrimeNumber(number!);
      outputMessage =
          'Số $number vừa nhập ${isPrimeNumber ? 'có' : 'không'} là số nguyên tố.';
    });
  }

  bool _isPrimeNumber(int number) {
    if (number < 2) return false;
    for (var i = 2; i <= number / 2; i++) {
      if (number % i == 0) return false;
    }
    return true;
  }
}
