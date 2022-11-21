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
const imageHeight = 300.0;

/// It is a compile-time error for any type other than [int] or [double] to attempt to extend or implement `num`.
extension Normalize on num{
num normalized(
    num selfRangeMin,
    num selfRangeMax,[
      num normalizedRangeMin = 0.0,
      num normalizedRangeMax = 1.0,

]
    ) => (normalizedRangeMax - normalizedRangeMin) * ((this - selfRangeMin) / (selfRangeMax- selfRangeMin)) + normalizedRangeMin;
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final opacity = useAnimationController(duration: const Duration(seconds: 1),initialValue: 1.0,lowerBound: 0.0,upperBound: 1.0,);
    final size = useAnimationController(duration: const Duration(seconds: 1),initialValue: 1.0,lowerBound: 0.0,upperBound: 1.0,);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
    );
  }
}

