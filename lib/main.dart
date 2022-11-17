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

/// 1. creating a getter function to get the current time
Stream<String> getTime() => Stream.periodic(const Duration(seconds: 1),(_) => DateTime.now().toIso8601String());

/// 2. create your own hookwidget (stl)
/// Its usage is very similar to [StatelessWidget].
/// [HookWidget] does not have any life cycle and only implements
/// the [build] method.
///
class MyHomePage extends HookWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 3. Subscribes to a [Stream] and returns its current state as an [AsyncSnapshot].
    final dateTime = useStream(getTime());
    return Scaffold(
      appBar: AppBar(
        /// 4. consume the data of the stream in app bar
        title: Text(dateTime.data ?? "HomePage"),
      ),
    );
  }
}


