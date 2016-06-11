import 'package:flutter/material.dart';
import 'package:firebase/firebase.dart';

void main() {
  runApp(
    new MaterialApp(
      title: 'Multi-Counter',
      theme: new ThemeData(
        primarySwatch: Colors.blue
      ),
      home: new MultiCounter()
    )
  );
}

class MultiCounter extends StatefulWidget {
  MultiCounter({ Key key }) : super(key: key);

  @override
  _MultiCounterState createState() => new _MultiCounterState();
}

class _MultiCounterState extends State<MultiCounter> {
  int _counter = 0;
  DatabaseReference _counterReference = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.signInAnonymously().then((user) {
      _counterReference.onChildAdded.listen((Event event) {
        var val = event.snapshot.val();
        updateCounter(val['counter']);
      });
    });
  }

  void updateCounter(int counter) {
    setState(() {
      _counter = counter;
    });
  }

  void _decreaseCounter() {
    setState(() {
      _counter--;
      // _counterReference.child('counter').set({ 'counter' : _counter });
      _counterReference.push().set({ 'counter': _counter });
    });

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Multi Counter')
      ),
      body: new Center(
        child: new Text('Button tapped $_counter time${ _counter == 1 ? '' : 's' }.')
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _decreaseCounter,
        tooltip: 'Decrement',
        child: new Icon(
          icon: Icons.cancel
        )
      )
    );
  }
}
