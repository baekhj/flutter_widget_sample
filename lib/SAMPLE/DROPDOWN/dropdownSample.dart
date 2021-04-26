import 'package:flutter/material.dart';
import 'package:flutter_widget_sample/SAMPLE/DROPDOWN/dropdownUtil.dart';
import 'package:toast/toast.dart';

class dropdownSample extends StatefulWidget {

  final String title;
  final Map<String, dynamic> data;

  dropdownSample({this.title, this.data});
  @override
  _dropdownSampleState createState() => _dropdownSampleState();
}

class _dropdownSampleState extends State<dropdownSample> {

  String _selectValue = ''; //선택된값 처리용
  bool _isDisable = true; //disabled 처리용

  @override
  Widget build(BuildContext context) {

    List<dynamic> dataList = [
      {"text":"선택", "value":"",},
      {"text":"가", "value":"A",},
      {"text":"나", "value":"B",},
      {"text":"다", "value":"C",},
    ];

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
            SizedBox(
              height: 50,
              child: dropdownMenu(dataList, _selectValue, 1000, 30, false,_isDisable?null:(value){ //휴가 드롭다운
                String text = '';
                dataList.forEach((element) {
                  if(element['value']==value){
                    setState(() {
                      text = element['text'];
                      _selectValue = value;
                    });
                  }
                });
                Toast.show("text : "+text + " / value : " +value, context, duration: 1, gravity: 1);
              }),
            ),

          ],
        ),
      ),
    );
  }
}
