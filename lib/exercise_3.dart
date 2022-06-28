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

typedef ButtonPressedCallBack = void Function(int);

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int chooseNumber = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 480) {
            return Row(
              children: [
                Expanded(
                  child: FirstRoute(
                    isNavigate: false,
                    buttonPressed: (number) {
                      setState(() {
                        chooseNumber = number;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: SecondRoute(
                    isNavigate: false,
                    number: chooseNumber,
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: FirstRoute(isNavigate: true),
            );
          }
        },
      ),
    );
  }
}

class FirstRoute extends StatefulWidget {
  final bool isNavigate;
  final ButtonPressedCallBack? buttonPressed;
  const FirstRoute({
    Key? key,
    required this.isNavigate,
    this.buttonPressed,
  }) : super(key: key);

  @override
  State<FirstRoute> createState() => _FirstRouteState();
}

class _FirstRouteState extends State<FirstRoute> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _button(1),
        const SizedBox(height: 10),
        _button(2),
        const SizedBox(height: 10),
        _button(3),
        const SizedBox(height: 10),
        _button(4),
        const SizedBox(height: 10),
        _button(5),
      ],
    );
  }

  ElevatedButton _button(int number) {
    return ElevatedButton(
      onPressed: () {
        if (widget.isNavigate) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SecondRoute(
                isNavigate: widget.isNavigate,
                number: number,
              ),
            ),
          );
        } else if (widget.buttonPressed != null) {
          widget.buttonPressed!(number);
        }
      },
      child: Text(number.toString()),
    );
  }
}

class SecondRoute extends StatefulWidget {
  final bool isNavigate;
  final int number;
  const SecondRoute({
    Key? key,
    required this.isNavigate,
    required this.number,
  }) : super(key: key);

  @override
  State<SecondRoute> createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
  @override
  Widget build(BuildContext context) {
    String message = 'Bạn chưa chọn bất kỳ số nào.';
    if (widget.number > 0) {
      message = 'Bạn vừa chọn số ${widget.number}';
    }

    if (widget.isNavigate) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Text(message),
        ),
      );
    }

    return Center(
      child: Text(message),
    );
  }
}
