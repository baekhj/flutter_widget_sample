import 'package:flutter/material.dart';

class childWidget2 extends StatefulWidget {

  final Function callback;
  final Function parentSetState;
  final String parentTxt;
  final String parentTxt2;

  const childWidget2({Key key, this.callback, this.parentTxt, this.parentTxt2, this.parentSetState}) : super(key: key);

  @override
  _childWidget2State createState() => _childWidget2State();
}

class _childWidget2State extends State<childWidget2> {

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    //setState(() {});  //엄마위젯 상태변경시 변경된 정보(parentTxt가 반영됨
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      color: Colors.red[100],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('엄마의 문구(실시간반영) :'),
          Text('\t\t\t\t>>'+widget.parentTxt),
          Text('엄마의 문구(갱신시반영) :'),
          Text('\t\t\t\t>>'+widget.parentTxt2),
          RaisedButton(
            onPressed: () {
              setState(() {
                widget.parentSetState();
              });
            }, child: Text('엄마2번값 갱신!!'),
          ),
          Text('아래에 내용을 입력하세여'),
          TextField(
            onChanged: (value) => widget.callback(value),
          )
        ]
      ),
    );
  }
}
