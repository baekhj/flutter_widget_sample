import 'package:flutter/material.dart';
import 'package:flutter_widget_sample/SAMPLE/WIDGET/DATA/childWidget1.dart';
import 'package:flutter_widget_sample/SAMPLE/WIDGET/DATA/childWidget2.dart';

class ParentWidget extends StatefulWidget {

  final String title;
  final Map<String, dynamic> data;

  const ParentWidget({Key key, this.title, this.data}) : super(key: key);

  @override
  _ParentWidgetState createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  String _child1Text='';
  String _child2Text='';
  bool child2Open = false;
  TextEditingController txtCtr;
  String txt='';
  TextEditingController txtCtr2;
  String txt2='';

  Function child1Return(String text){
    setState(() {
      _child1Text = text;
    });
  }
  Function child2Return(String text){
    setState(() {
      _child2Text = text;
    });
  }
  Function curWidgetSetState(){
    setState(() {
    });
  }

  @override
  void initState() {
    super.initState();
    txtCtr = TextEditingController();
    txtCtr2 = TextEditingController();
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text('부모 / 자식 위젯간 데이터 참조'),
            Row(
              children: [
                Text('부모값(실시간반영) : '),
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: txtCtr,
                    onChanged: (value) {
                      txt = value;
                      setState(() {
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text('부모값2(부모창위잿갱신시반영) : '),
                SizedBox(
                  width: 140,
                  child: TextField(
                    controller: txtCtr2,
                    onChanged: (value) {
                      txt2 = value;
                      /*setState(() {
                      });*/
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text('자식1에서 입력한 값 : '),
                Text(_child1Text),
              ],
            ),
            Row(
              children: [
                Text('자식2에서 입력한 값 : '),
                Text(_child2Text),
              ],
            ),
            Row(
              children: [
                RaisedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) => childWidget1(callback: child1Return,)
                        )
                    );
                  },
                  child: Text('자식1열기'),
                ),
                RaisedButton(
                  onPressed: () {
                    child2Open = !child2Open;
                    setState(() {
                    });
                  },
                  child: Text('자식2열기/닫기'),
                ),
              ],
            ),
            Visibility(
              visible: child2Open,
              child: StatefulBuilder(
                builder: (context, setState) => childWidget2(callback: child2Return,parentTxt: txt,parentTxt2: txt2, parentSetState: curWidgetSetState,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

