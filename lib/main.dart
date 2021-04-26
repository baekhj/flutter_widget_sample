import 'package:flutter/material.dart';
import 'package:flutter_widget_sample/sampleList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Widget Sample',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SampleList(title: "Widget Sample",),
    );
  }
}

