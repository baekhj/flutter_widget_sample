import 'package:flutter/material.dart';
import 'package:flutter_widget_sample/SAMPLE/WIDGET/DATA/parentWidget.dart';

class widgetDataLinkSample extends StatefulWidget {

  final String title;
  final Map<String, dynamic> data;

  widgetDataLinkSample({this.title, this.data});

  @override
  _widgetDataLinkSampleState createState() => _widgetDataLinkSampleState();
}

class _widgetDataLinkSampleState extends State<widgetDataLinkSample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ),
      body: StatefulBuilder(
        builder: (context, setState) => ParentWidget(title: widget.title, data: widget.data,),
      ),
    );
  }
}
