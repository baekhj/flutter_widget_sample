import 'package:flutter/material.dart';
import 'file:///C:/work/work_Dir/github/flutter_widget_sample/lib/SAMPLE/WIDGET/DATA2/parentWidget2.dart';

class widgetDataLinkSample2 extends StatefulWidget {

  final String title;
  final Map<String, dynamic> data;

  widgetDataLinkSample2({this.title, this.data});

  @override
  _widgetDataLinkSample2State createState() => _widgetDataLinkSample2State();
}

class _widgetDataLinkSample2State extends State<widgetDataLinkSample2> {
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
        builder: (context, setState) => ParentWidget2(title: widget.title, data: widget.data,),
      ),
    );
  }
}
