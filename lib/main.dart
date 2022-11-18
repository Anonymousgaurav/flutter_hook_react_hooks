import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

extension CompactMap<T> on Iterable<T?>{
  Iterable<T> compactMap<E>([E? Function(T?)? transform]) => map(transform ?? (e) => e).where((e) => e != null).cast();
}

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

const url = "https://www.studyinserbia.rs/uploads/attachment/strana/228/large_tara-mountain-5520592_1920.jpg";

class MyHomePage extends HookWidget {

  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// grab the image from url
    final future = useMemoized(() => NetworkAssetBundle(Uri.parse(url)).load(url).then((data) => data.buffer.asUint8List()).then((data) => Image.memory(data)));
    /// useFuture is a hook widget and we will use if we have to return Future function
    /// useMemoized allows caching of complex objects
    final snapshot = useFuture(future);
    return Scaffold(
      appBar: AppBar(
        title: const Text("HomePage"),
      ),
      body: Column(
        children: [
          snapshot.data
        ].compactMap().toList(),
      ),
    );
  }
}