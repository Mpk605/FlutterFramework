import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:
          'Exercice 1',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Exercice 1'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

/// Hello World Page opened when the counter reaches 11
class HelloWorldPage extends StatelessWidget {
  const HelloWorldPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello World'),
      ),
      body: const Center(
        child: Text(
          "Hello World",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32.0),
        ),
      ),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  /// Increments _counter with increment (positive or negative)
  /// and opens HelloWorldPage when it reaches 11 (>10) and resets it to 0
  void _incrementCounter(int increment) {
    setState(() {
      _counter += increment;

      if (_counter > 10) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HelloWorldPage()));
        _counter = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(padding: EdgeInsets.all(16.0)),
            Card(
              color: const Color(0xffdfebf9),
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                child: Column(
                  children: [
                    const Text(
                      'Compteur :',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 16.0)),
                    Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () => _incrementCounter(-1),
                              tooltip: 'Decrement'),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 16.0, left: 16.0),
                              child: Text(
                                '$_counter',
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ),
                          ),
                          IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () => _incrementCounter(1),
                              tooltip: 'Increment'),
                        ]),
                  ],
                ),
              ),
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
