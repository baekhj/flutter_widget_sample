import 'package:flutter/material.dart';
import 'package:flutter_widget_sample/SAMPLE/AES/aesScryptoJSSample.dart';
import 'package:flutter_widget_sample/SAMPLE/CLOSEPOP/containerPopSample.dart';
import 'package:flutter_widget_sample/SAMPLE/DATEPICKER/datePickerSample.dart';
import 'package:flutter_widget_sample/SAMPLE/DROPDOWN/dropdownSample.dart';
import 'package:flutter_widget_sample/SAMPLE/REST/restCallSample.dart';
import 'package:flutter_widget_sample/SAMPLE/STORAGE/flutterSecureStorageSample.dart';
import 'package:flutter_widget_sample/SAMPLE/SWIPE/swipeSample_list.dart';
import 'package:flutter_widget_sample/SAMPLE/TEXT/TextWidget.dart';
import 'package:flutter_widget_sample/SAMPLE/WIDGET/DATA/WidgetDataLinkSample.dart';

class SampleList extends StatefulWidget {
  String title;
  Map<String, dynamic> data;
  SampleList({this.title, this.data});
  @override // createState() = 위젯 생성 후 실행
  _SampleListState createState() => _SampleListState();
}

class _SampleListState extends State<SampleList> {

  List<RowData> dataList;
  TextEditingController valCtr; //FieldController..

  
  @override
  void initState() {
    super.initState();
    valCtr = TextEditingController();

  }

  @override
  void didChangeDependencies() {  
    //initState 호출된 후 호출되는 아이
    //initState 와 다르게 의존하는 위젯이 변경되면 다시 호출됨
    super.didChangeDependencies();
    print("didChangeDependencies");
  }

  @override
  void didUpdateWidget(covariant SampleList oldWidget) {  //부모위젯이 재빌드되어 위젯이 갱신될때
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  @override
  void deactivate() { //본인이 제거될때구만
    print("deactivate");
  }

  @override
  Widget build(BuildContext context) {

    dataList = [
      RowData(
          info: 'WidgetSample 다시띄우기 (Navigator.push)',
          widget: SampleList(title: 'WidgetSample 다시띄우기 (Navigator.push)',data:{"note":"가나다라"})
      ),
      RowData(
          info: 'Swipe Widget (화면 좌우스크롤전환)',
          widget: swipeSampleList(title: 'Swipe Widget (화면 좌우스크롤전환)')
      ),
      RowData(
          info: 'Text Widget',
          widget: TextWidgetSample(title: 'Text Widget')
      ),
      RowData(
          info: 'DropDown Sample',
          widget: dropdownSample(title: 'DropDown Sample')
      ),
      RowData(
          info: 'DatePicker Sample',
          widget: datepickerSample(title: 'DatePicker Sample')
      ),
      RowData(
          info: 'aesScryptoJSSample Sample',
          widget: aesScryptoJSSample(title: 'aesScryptoJSSample Sample (암/복호화)')
      ),
      RowData(
          info: 'FlutterSecureStorage Sample',
          widget: flutterSecureStorageSample(title: 'FlutterSecureStorage Sample')
      ),
      RowData(
          info: 'RestCall Sample',
          widget: restCallSample(title: 'RestCall Sample')
      ),
      RowData(
          info: 'Container Pop Sample (화면클릭시 위젯 닫기)',
          widget: containerPopSample(title: 'Container Pop Sample')
      ),
      RowData(
          info: 'Widget DataLink Sample (위젯간 데이터 참조??연계??)',
          widget: widgetDataLinkSample(title: 'Widget DataLink Sample')
      ),

    ];

    List<ListTile> bodyData = [];
    for(int x=0; x < dataList.length; x++){
      if(valCtr.text != null && valCtr.text != ''){
        if(dataList[x].info.toLowerCase().contains(valCtr.text.toLowerCase())){
          bodyData.add(createListTile(dataList[x]));
        }
      }else{
        bodyData.add(createListTile(dataList[x]));
      }
    }
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
                height: 80,
                child: Container(
                  width: MediaQuery.of(context).size.width*0.8,
                  child: TextField(
                    controller: valCtr,
                    decoration: InputDecoration(
                      labelText: '검색',
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height*0.8,
                child: ListView(
                  children: bodyData,
                ),
              ),
            ],
        ),
      ),
    );
  }

  ListTile createListTile(RowData data){
    return ListTile(
      title : Text(
        data.info,
        style: TextStyle(
          fontSize: 12,
        ),
      ),
      onTap: () => openPage(context, data),
    );
  }
}

void openPage(BuildContext context, RowData data){
  print('Open !!  >> ' + data.info);
  Navigator.push(context,
      MaterialPageRoute(
          builder: (context) => data.widget
      )
  );
}

class RowData {
  String info;
  StatefulWidget widget;

  RowData({this.info, this.widget});

  @override
  String toString(){
    String  msg = '-------------------------------------------------------------------------------------------------------------------------------------\n';
    msg += 'RowDataVO.Result[] \n';
    msg += '\t info : ${info.toString()} \n';
    msg += '\w idget : $widget \n';
    msg += '-------------------------------------------------------------------------------------------------------------------------------------';
    return msg;
  }


}


