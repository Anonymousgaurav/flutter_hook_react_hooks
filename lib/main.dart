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


class MyHomePage extends HookWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final countDown = useMemoized(() => CountDownTimer(from: 20));
    final notifier = useListenable(countDown);
    print("Helloooo");

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Text(notifier.value.toString()),
    );
  }
}



/// 1. create a class with ValueNotifier

class CountDownTimer extends ValueNotifier<int>{
  /// 2. Create a StreamSubscription
  late StreamSubscription sub;
  /// emit the value every second after doing process from - v and take while value >= 0 then subscription stops
  CountDownTimer({required int from}) : super(from) {
    sub = Stream.periodic(const Duration(seconds: 1),(v) => from - v ).takeWhile((value) => value >= 0).listen((event) {
      value = event;
    });
  }

  /// 3. Dispose your Subscription
  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }
}
