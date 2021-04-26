import 'package:flutter/material.dart';
import 'package:toast/toast.dart';


class swipePage extends StatefulWidget {

  final String title;
  final int standDataKey;
  final List<Map<String, dynamic>> widgetDataList;

  const swipePage({Key key, this.title, this.standDataKey, this.widgetDataList}) : super(key: key);

  @override
  _swipePageState createState() => _swipePageState();
}

class _swipePageState extends State<swipePage> {

  int _standDataKey;  //데이터 조회 키값

  PageController _pc;


  List<Map<String, dynamic>> _dataList;

  bool _pageClose = false;

  @override
  void dispose(){
    _pc.dispose();
    super.dispose();
  }

  @override
  void initState(){
    super.initState();

    _standDataKey = widget.standDataKey;
    _dataList = widget.widgetDataList;

    int curIdx = -1;
    for(int i=0;i<_dataList.length; i++){
      if(_dataList[i]['standDataKey'] == 777 || _dataList[i]['standDataKey'] == 888 ) continue; //잘못된 요청 처리용으로 제외

      if(_dataList[i]['standDataKey'] == _standDataKey){
        curIdx = i;
        break;
      }
    }
    print('curIdx : ' + curIdx.toString());
    if(curIdx==-1) _pageClose = true;

    _pc = PageController(
      initialPage: curIdx,
    );
    
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      print("열리는 페이지 : "+curIdx.toString());
      if(_pageClose){ //열수없는 페이지 일때 닫아 주기
        Toast.show("잘못된 요청입니다.", context, duration: 1, gravity: 1);
        Navigator.pop(context);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    List<Widget> wList = [];
    for(int i=0;i<_dataList.length; i++){
      wList.add(DetailPageWidget(detailData: _dataList[i], callback: reSetWList));
    }
    print(wList);
    return PageView(
      controller: _pc,
      children: wList,
    );
  }
  void reSetWList(){
    setState(() {
      print('위젯갱신');
    });
  }

}

class DetailPageWidget extends StatefulWidget {
  final Function callback;
  final Map<String, dynamic> detailData;

  const DetailPageWidget({Key key, this.detailData, this.callback}) : super(key: key);

  @override
  _DetailPageWidgetState createState() => _DetailPageWidgetState();
}
class _DetailPageWidgetState extends State<DetailPageWidget> {
  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.callback();
    });
  }
  @override
  Widget build(BuildContext context) {
    print(widget.detailData['title'].toString()+" 빌드!  "+widget.detailData['standDataKey'].toString());
    return Scaffold(
     /* appBar: AppBar(
        title: Text("문서번호 - "+widget.detailData['standDataKey'].toString()),
      ),*/
      body: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 16,
        child: Container(
          width: MediaQuery.of(context).size.width*0.9,
          height: MediaQuery.of(context).size.height*0.9,
          child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("문서번호 - "+widget.detailData['standDataKey'].toString()),
                  Text(""+widget.detailData['title'].toString()),
                ],
              ),
          ),
          color: Colors.white,
        ),
      ),
    );
  }
}

