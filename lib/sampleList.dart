import 'package:flutter/material.dart';
import 'package:flutter_widget_sample/SAMPLE/DROPDOWN/dropdownSample.dart';
import 'package:flutter_widget_sample/SAMPLE/SWIPE/swipeSample_list.dart';
import 'package:flutter_widget_sample/SAMPLE/TEXT/TextWidget.dart';

class SampleList extends StatefulWidget {
  String title;
  Map<String, dynamic> data;
  SampleList({this.title, this.data});
  @override
  _SampleListState createState() => _SampleListState();
}

class _SampleListState extends State<SampleList> {

  List<RowData> dataList;

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

    ];


    List<ListTile> bodyData = [];
    for(int x=0; x < dataList.length; x++){
      bodyData.add(createRowData(dataList[x]));
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
      body: ListView(
        children: bodyData,
      ),);
  }

  ListTile createRowData(RowData data){
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


