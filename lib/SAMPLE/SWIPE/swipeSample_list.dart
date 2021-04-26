import 'package:flutter/material.dart';
import 'package:flutter_widget_sample/SAMPLE/SWIPE/swipeSample_detail.dart';

class swipeSampleList extends StatefulWidget {

  final String title;
  final Map<String, dynamic> data;

  swipeSampleList({this.title, this.data});

  @override
  _swipeSampleListState createState() => _swipeSampleListState();
}

class _swipeSampleListState extends State<swipeSampleList> {

  List<Map<String, dynamic>> dataList;

  @override
  Widget build(BuildContext context) {
    //실제 그려줘야할 아이들 목록
    dataList = [
      {'type':'1', 'title':'휴가신청서(2021.04.20) - 백호준', 'standDataKey':120},
      {'type':'2', 'title':'외근신청서(2021.04.10) - 조수빈', 'standDataKey':21},
      {'type':'3', 'title':'야근신청서(2021.04.12) - 이재우', 'standDataKey':32},
      {'type':'4', 'title':'특근신청서(2021.04.23) - 조수빈', 'standDataKey':133},
      {'type':'5', 'title':'시간외근무신청서(2021.03.20) - 이재우', 'standDataKey':42},
      {'type':'1', 'title':'휴가신청서(2021.03.15) - 백호준', 'standDataKey':521},
      {'type':'1', 'title':'휴가신청서(2021.03.11) - 백호준', 'standDataKey':196},
      {'type':'6', 'title':'비품구매품의서(2021.03.10) - 백호준', 'standDataKey':1237},
      {'type':'7', 'title':'지급결의서(2021.03.03) - 조훈', 'standDataKey':128},
      {'type':'8', 'title':'외근보고서(2021.03.01) - 조훈', 'standDataKey':1239},
      {'type':'9', 'title':'출퇴근시간변경신청서(2021.02.28) - 백호준', 'standDataKey':100},
      {'type':'1', 'title':'휴가신청서(2021.02.23) - 이재우', 'standDataKey':777},
      {'type':'1', 'title':'휴가신청서(2021.02.22) - 이재우', 'standDataKey':888},
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
      ),
    );
  }

  ListTile createRowData(Map<String, dynamic> data){
    IconData ic;
    if(data['type']=='1') ic = Icons.bathtub;
    else if(data['type']=='2') ic = Icons.access_time;
    else if(data['type']=='3') ic = Icons.wb_incandescent;
    else if(data['type']=='4') ic = Icons.addchart_outlined;
    else if(data['type']=='5') ic = Icons.timelapse_rounded;
    else if(data['type']=='6') ic = Icons.add;
    else if(data['type']=='7') ic = Icons.money_off;
    else if(data['type']=='8') ic = Icons.report_gmailerrorred_outlined;
    else if(data['type']=='9') ic = Icons.change_history;
    return ListTile(
      leading: Icon(ic) ,
      title : Text(
        data['title'],
      ),
      onTap: () => openPage(context, data, dataList),
    );
  }
}
void openPage(BuildContext context, Map<String, dynamic> data, List<Map<String, dynamic>> allList){
  Navigator.push(context,
      MaterialPageRoute(
          builder: (context) => swipePage(title: data['title'], standDataKey: data['standDataKey'], widgetDataList:allList)
      )
  );
}

