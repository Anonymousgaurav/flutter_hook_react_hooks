import 'dart:async';

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

const url = "https://bit.ly/3x7J5Qt";

class MyHomePage extends HookWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final StreamController<double> streamController;
    streamController = useStreamController<double>(onListen: () {
      streamController.sink.add(0.0);
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stream Controller"),
      ),
      /// Creates a rotation transition.
      body: StreamBuilder<double>(
          stream: streamController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final rotation = snapshot.data ?? 0.0;
              return GestureDetector(
                onTap: () {
                  streamController.sink.add(rotation + 10.0);
                },
                child: RotationTransition(
                    /// An animation that is always stopped at a given value. The [status] is always [AnimationStatus.forward].
                    turns: AlwaysStoppedAnimation(rotation / 360),
                    child: Center(child: Image.network(url))),
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }
}
