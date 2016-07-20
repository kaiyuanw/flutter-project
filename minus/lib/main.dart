import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:flutter/http.dart' as http;

import 'keys.dart';

const String getCounterUrl = 'http://shared-counter.appspot.com/get_count';
const String decreaseCounterUrl = 'http://shared-counter.appspot.com/dec_count';

void main() {
  runApp(
    new MaterialApp(
      title: 'Decrease Counter',
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

  @override
  void initState() {
    super.initState();
    listenToGetCounter();
  }

  Future<Null> listenToGetCounter() async {
    while (true) {
      // pingUrl(getCounterUrl);
      pingUrlAsync(getCounterUrl);
      await new Future<Null>.delayed(new Duration(milliseconds: 500));
    }
  }

  // void pingUrl(String url) {
  //   http.get(url).then((http.Response response) {
  //     String json = response.body;
  //     if (json == null) {
  //       print("Failed to get count from $url");
  //       return;
  //     }
  //     JsonDecoder decoder = new JsonDecoder();
  //     dynamic obj = decoder.convert(json);
  //     if (_counter != obj['count']) {
  //       updateCounter(obj['count']);
  //     }
  //   });
  // }

  Future<Null> pingUrlAsync(String url) async {
    HttpClient client = new HttpClient();
    HttpClientRequest request = await client.getUrl(Uri.parse(url));
    HttpClientResponse response = await request.close();
    response.transform(new Utf8Decoder()).listen((String body) {
      updateCounter(JSON.decode(body)['count']);
    });
  }

  void updateCounter(int counter) {
    setState(() {
      _counter = counter;
    });
  }

  void _decreaseCounter() {
    setState(() {
      // pingUrl(decreaseCounterUrl);
      pingUrlAsync(decreaseCounterUrl);
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Multi Counter')
      ),
      body: new Center(
        child: new Text(
          'Button tapped $_counter time${ _counter == 1 ? '' : 's' }.',
          style: textTheme.display3,
          key: new ValueKey(textKey)
        )
      ),
      floatingActionButton: new FloatingActionButton(
        key: new ValueKey(buttonKey),
        onPressed: _decreaseCounter,
        tooltip: 'Decrement',
        child: new Icon(Icons.cancel)
      )
    );
  }
}
