import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// 1.
enum Action { rotateRight, rotateLeft, moreVisible, lessVisible }

///2.
@immutable
class State {
  final double rotationDec;
  final double alpha;

  const State({required this.rotationDec, required this.alpha});

  /// initial state
  const State.zero()
      : rotationDec = 0.0,
        alpha = 1.0;

  /// declare actions
  State rotationRight() => State(alpha: alpha, rotationDec: rotationDec + 10.0);

  State rotationLeft() => State(alpha: alpha, rotationDec: rotationDec - 10.0);

  State increaseAlpha() =>
      State(alpha: min(alpha + 0.1, 1.0), rotationDec: rotationDec);

  State decreaseAlpha() =>
      State(alpha: max(alpha - 0.1, 0.0), rotationDec: rotationDec);
}

/// 3.
State reducer(State oldState, Action? action) {
  switch (action) {
    case Action.rotateLeft:
      return oldState.rotationLeft();
    case Action.rotateRight:
      return oldState.rotationRight();
    case Action.moreVisible:
      return oldState.increaseAlpha();
    case Action.lessVisible:
      return oldState.decreaseAlpha();
    default:
      return oldState;
  }
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

class MyHomePage extends HookWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// [reducer] is immediately called on first build with [initialAction]
    /// and [initialState] as parameter. It is possible to change the [reducer] by calling [useReducer]
    /// with a new [Reducer].
    final store = useReducer<State, Action?>(reducer,
        initialState: const State.zero(), initialAction: null);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home Page"),
        ),
        body: Column(
          children: [
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      store.dispatch(Action.rotateLeft);
                    },
                    child: const Text("Rotate Left")),
                TextButton(
                    onPressed: () {
                      store.dispatch(Action.rotateRight);
                    },
                    child: const Text("Rotate Right")),
                TextButton(
                    onPressed: () {
                      store.dispatch(Action.lessVisible);

                    },
                    child: const Text("Increase Alpha")),
                TextButton(
                    onPressed: () {
                      store.dispatch(Action.moreVisible);

                    },
                    child: const Text("Decrease Alpha")),
              ],
            ),
            const SizedBox(
              height: 100.0,
            ),
            Opacity(
              opacity: store.state.alpha,
              child: RotationTransition(
                /// An animation that is always stopped at a given value.
                turns: AlwaysStoppedAnimation(store.state.rotationDec / 360.0),
                child: Image.network("https://www.mindinventory.com/blog/wp-content/uploads/2022/05/flutter-3.png"),
              ),
            ),
          ],
        ));
  }
}
