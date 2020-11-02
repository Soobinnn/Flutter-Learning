import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//void main() => runApp(MyApp());
//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Provider<int>.value(
//        value: 5,
//        child: MaterialApp(
//          title: 'Flutter Demo',
//          theme: ThemeData(
//            primarySwatch: Colors.blue,
//          ),
//          home: HomePage(),
//        )
//    );
//  }
//}
//
//class HomePage extends StatefulWidget {
//  @override
//  _HomePageState createState() => _HomePageState();
//}
//class _HomePageState extends State<HomePage> {
//  @override
//  Widget build(BuildContext context) {
//    var data = Provider.of<int>(context);
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('reasley'),
//      ),
//      body: Center(
//        child: Text( '$data', style: Theme.of(context).textTheme.headline4, ),
//      ),
//    );
//  }
//}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Provider Pattern Example',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider<Counter>(
        create: (_) => Counter(0),
        child: HomePage(),
      ),
    );
  }
}
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<Counter>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("reasley"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${counter.getCounter()}',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: counter.increment,
            tooltip: 'Increment',
            child: Icon(Icons.add),
            heroTag: null,
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: counter.decrement,
            tooltip: 'Decrement',
            child: Icon(Icons.remove),
            heroTag: null,
          )
        ],
      ),
    );
  }
}
class Counter with ChangeNotifier {
  int _counter;
  Counter(this._counter);
  getCounter() => _counter;
  setCounter(int counter) => _counter = counter;
  void increment() {
    _counter++;
    notifyListeners();
  }
  void decrement() {
    _counter--;
    notifyListeners();
  }
}