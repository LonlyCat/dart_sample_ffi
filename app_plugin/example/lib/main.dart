import 'package:flutter/material.dart';
import 'dart:async';

import 'package:algorithm_plugin/algorithm_plugin.dart' as algorithm_plugin;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

const int _fibonacciNumber = 40;
class _MyAppState extends State<MyApp> {

  late _Calculator<int> fibonacciResult = _Calculator(() => algorithm_plugin.fibonacci(_fibonacciNumber));
  late _Calculator<int> fibonacciDartResult = _Calculator(() => fibonacciDart(_fibonacciNumber));
  late _CalculatorAsync<int> fibonacciAsyncResult = _CalculatorAsync(() => algorithm_plugin.fibonacciAsync(_fibonacciNumber));

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 25);
    const spacerSmall = SizedBox(height: 10);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Native Packages'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const Text(
                  'This is a example of using a native package by FFI',
                  style: textStyle,
                  textAlign: TextAlign.center,
                ),
                spacerSmall,
                const Text(
                  'Calculating fibonacci($_fibonacciNumber) sync',
                  style: textStyle,
                  textAlign: TextAlign.center,
                ),
                spacerSmall,
                if (fibonacciResult.hasValue)
                  Text(
                    'ffi sync res = ${fibonacciResult.value}'
                    '\nffi sync duration = ${fibonacciResult.elapsed.inMilliseconds} ms',
                    style: textStyle,
                    textAlign: TextAlign.center,
                  ),
                if (fibonacciDartResult.hasValue)
                  Text(
                    'dart sync res = ${fibonacciDartResult.value}'
                    '\ndart sync duration = ${fibonacciDartResult.elapsed.inMilliseconds} ms',
                    style: textStyle,
                    textAlign: TextAlign.center,
                  ),
                spacerSmall,
                TextButton(
                  onPressed: () {
                    fibonacciResult.start();
                    fibonacciDartResult.start();
                    setState(() {});
                  },
                  child: const Text('Start fibonacci sync'),
                ),
                spacerSmall,
                const Text(
                  'Calculating fibonacci($_fibonacciNumber) async',
                  style: textStyle,
                  textAlign: TextAlign.center,
                ),
                spacerSmall,
                if (fibonacciAsyncResult.hasValue)
                  Text(
                    'ffi async res = ${fibonacciAsyncResult.value}'
                    '\nffi async duration = ${fibonacciAsyncResult.elapsed.inMilliseconds} ms',
                    style: textStyle,
                    textAlign: TextAlign.center,
                  ),
                TextButton(
                  onPressed: () async {
                    await fibonacciAsyncResult.start();
                    setState(() {});
                  },
                  child: const Text('Start fibonacci async'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Dart 实现
  int fibonacciDart(int n) {
    if (n <= 1) return n;
    return fibonacciDart(n - 1) + fibonacciDart(n - 2);
  }
}

class _Calculator<T> {
  _Calculator(this._handler);

  T? _value;
  final T Function() _handler;
  late final Stopwatch _stopwatch = Stopwatch();

  Duration get elapsed => _stopwatch.elapsed;
  bool get hasValue => _value != null;
  T get value {
    if (_value == null) {
      throw StateError('The calculator has not been started.');
    }
    return _value!;
  }

  void start() {
    if (hasValue) {
      _stopwatch.reset();
    }
    _stopwatch.start();
    _value = _handler();
    _stopwatch.stop();
  }
}

class _CalculatorAsync<T> {
  _CalculatorAsync(this._handler);

  T? _value;
  final Future<T> Function() _handler;
  late final Stopwatch _stopwatch = Stopwatch();

  Duration get elapsed => _stopwatch.elapsed;
  bool get hasValue => _value != null;
  T get value {
    if (_value == null) {
      throw StateError('The calculator has not been started.');
    }
    return _value!;
  }

  Future<void> start() async {
    if (hasValue) {
      _stopwatch.reset();
    }
    _stopwatch.start();
    _value = await _handler();
    _stopwatch.stop();
  }
}
