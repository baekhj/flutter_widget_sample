import 'package:flutter/material.dart';
import 'package:flutter_widget_sample/SAMPLE/DATEPICKER/DatePickUtil.dart';
import 'package:intl/intl.dart' as intl;
import 'package:toast/toast.dart';

class datepickerSample extends StatefulWidget {

  final String title;
  final Map<String, dynamic> data;

  datepickerSample({this.title, this.data});

  @override
  _datepickerSampleState createState() => _datepickerSampleState();
}

class _datepickerSampleState extends State<datepickerSample> {


  TextEditingController dateCtr; //FieldController..

  @override
  void initState() {
    super.initState();
    dateCtr = TextEditingController();
    DateTime a = DateTime.now();
    dateCtr.text = intl.DateFormat('yyyy-MM-dd').format(a);
  }

  @override
  Widget build(BuildContext context) {

    InputDecoration deco = InputDecoration.collapsed(
      hintText: "선 택",
      hintStyle: TextStyle(fontSize: 13,color: Colors.black38),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            select_calendarCallback(context, dateCtr, deco, (str){
              FocusScopeNode currentFocus = FocusScope.of(context);
              currentFocus.unfocus();
              Toast.show("이벤트처리하세요~", context, duration: 1, gravity: 1);
            }),
          ],
        ),
      ),
    );
  }
}
