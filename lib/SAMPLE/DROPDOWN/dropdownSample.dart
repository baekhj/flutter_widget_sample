import 'package:flutter/material.dart';
import 'package:flutter_widget_sample/SAMPLE/BUTTON/buttonUtil.dart';
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
  bool _isDisable = false; //disabled 처리용

  TextEditingController valCtr; //FieldController..

  @override
  void initState() {
    super.initState();
    valCtr = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {

    List<dynamic> dataList = [
      {"text":"선택", "value":"",},
      {"text":"가", "value":"A",},
      {"text":"나", "value":"B",},
      {"text":"다", "value":"C",},
      {"text":"라", "value":"D",},
      {"text":"마", "value":"E",},
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width*0.45,
                  child: TextField(
                    controller: valCtr,
                    decoration: InputDecoration(
                      labelText: 'DropBox Value',
                    ),
                  ),
                ),
                bottomDefaultBtn("선택", MediaQuery.of(context).size.width*0.45, () {
                  bool isOk = false;
                  dataList.forEach((element) {
                    if(element['value']==valCtr.text){
                      isOk = true;
                      setState(() {
                        _selectValue = valCtr.text;
                      });
                    }
                  });
                  if(isOk == false){
                    Toast.show("데이터가  존재하지 않습니다.", context, duration: 1, gravity: 1);
                  }else{
                    valCtr.text = '';
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    currentFocus.unfocus();
                  }
                }),
              ],
            ),
            cancelBottomBtn("값초기화/비활성화", MediaQuery.of(context).size.width*0.9, () {
              setState(() {
                _selectValue='';
                _isDisable = true;
              });
            }),
            approBottomBtn("활성화", MediaQuery.of(context).size.width*0.9, () {
              setState(() {
                _isDisable = false;
              });
            }),
          ],
        ),
      ),
    );
  }
}
