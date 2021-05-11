import 'package:flutter/material.dart';
import 'package:flutter_widget_sample/SAMPLE/BUTTON/buttonUtil.dart';
import 'package:flutter_widget_sample/SAMPLE/WIDGET/DATA2/DataVO.dart';

class childWidget2 extends StatefulWidget {

  DataVO data;
  Function callback;

  childWidget2(DataVO vo, Function callback){
    this.data = vo;
    this.callback = callback;
  }

  @override
  _childWidget2State createState() => _childWidget2State();
}

class _childWidget2State extends State<childWidget2> {

  TextEditingController txtCtr;
  String txt='';
  TextEditingController txtCtr2;
  String txt2='';

  DataVO data;

  @override
  void initState() {
    super.initState();
    this.data = widget.data;
    txtCtr = TextEditingController();
    txtCtr.text = this.data.str;
    txtCtr2 = TextEditingController();
    txtCtr2.text = this.data.bigo;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //setState(() {});  //엄마위젯 상태변경시 변경된 정보(parentTxt가 반영됨
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AlertDialog(
        backgroundColor: Colors.white, //Color(0xFF9E9E9E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        contentPadding: EdgeInsets.all(10),
        content: Container(
          height: MediaQuery.of(context).size.height*0.4,
          width:  MediaQuery.of(context).size.width*0.7,
          color: Colors.black26.withOpacity(0.1),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('No :'),
                    Text(''+data.no),
                  ]
                ),
                Row(
                  children: [
                    Text('일자 :'),
                    Text(''+data.ymd),
                  ]
                ),
                Row(
                  children: [
                    Text('입력 :'),
                    SizedBox(
                      width: 200,
                      child: TextField(
                        controller: txtCtr,
                        onChanged:(value) {
                          data.str = value;
                        },
                      ),
                    ),
                  ]
                ),
                Row(
                  children: [
                    Text('비고 :'),
                    SizedBox(
                      width: 200,
                      child: TextField(
                        controller: txtCtr2,
                        onChanged:(value) {
                          data.bigo = value;
                        },
                      ),
                    ),
                  ]
                ),
                Container(
                  width: 1000,
                  child: defaultBottomBtn('저장&닫기', 100, (){
                    widget.callback(null);
                    Navigator.pop(context);
                  }),
                ),
              ]
          ),
        ),
      ),
    );
  }
}
