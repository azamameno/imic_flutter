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
      home: const MyHomePage(),
    );
  }
}

typedef ButtonPressedCallBack = void Function();

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool showLoginForm = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 255, 180, 255),
              Color.fromARGB(255, 255, 180, 130),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 350,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 190, 53, 11),
                borderRadius: BorderRadius.circular(20),
              ),
              transform: Matrix4.rotationZ(-0.2),
              child: const Text(
                'MyShop',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 300,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(3, 3),
                  ),
                ],
              ),
              child: showLoginForm
                  ? LoginForm(onChangeForm: _onChangeForm)
                  : SignUpForm(onChangeForm: _onChangeForm),
            ),
          ],
        ),
      ),
    );
  }

  void _onChangeForm() {
    setState(() => showLoginForm = !showLoginForm);
  }
}

class LoginForm extends StatefulWidget {
  final ButtonPressedCallBack onChangeForm;
  const LoginForm({
    Key? key,
    required this.onChangeForm,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            hintText: 'E-Mail',
          ),
        ),
        TextFormField(
          decoration: const InputDecoration(
            hintText: 'Password',
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                const Color.fromARGB(255, 156, 39, 176)),
            padding: MaterialStateProperty.all(
                const EdgeInsets.fromLTRB(30, 15, 30, 15)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            )),
          ),
          child: const Text('LOGIN'),
        ),
        const SizedBox(height: 10),
        TextButton(
          onPressed: widget.onChangeForm,
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(
                const Color.fromARGB(255, 156, 39, 176)),
          ),
          child: const Text('SIGNUP INSTEAD'),
        ),
      ],
    );
  }
}

class SignUpForm extends StatefulWidget {
  final ButtonPressedCallBack onChangeForm;
  const SignUpForm({
    Key? key,
    required this.onChangeForm,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            hintText: 'E-Mail',
          ),
        ),
        TextFormField(
          decoration: const InputDecoration(
            hintText: 'Password',
          ),
        ),
        TextFormField(
          decoration: const InputDecoration(
            hintText: 'Confirm Password',
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                const Color.fromARGB(255, 156, 39, 176)),
            padding: MaterialStateProperty.all(
                const EdgeInsets.fromLTRB(30, 15, 30, 15)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            )),
          ),
          child: const Text('SIGN UP'),
        ),
        const SizedBox(height: 10),
        TextButton(
          onPressed: widget.onChangeForm,
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(
                const Color.fromARGB(255, 156, 39, 176)),
          ),
          child: const Text('LOGIN INSTEAD'),
        ),
      ],
    );
  }
}
