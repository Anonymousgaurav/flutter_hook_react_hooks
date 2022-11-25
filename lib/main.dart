import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

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

class MyHomePage extends HookWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Returns the current [AppLifecycleState] value and rebuilds the widget when it changes.
    final lifeCycle = useAppLifecycleState();
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Home Page"),
      ),
      body: Opacity(
        opacity: lifeCycle == AppLifecycleState.resumed ? 1.0 : 0.0,
        child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 10.0,
                  color: Colors.black.withAlpha(100),
                  spreadRadius: 10.0
                )
              ]
            ),child: Image.asset("assets/credit_card.png"),
        ),
      ),
    );
  }
}

