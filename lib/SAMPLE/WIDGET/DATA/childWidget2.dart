import 'package:flutter/material.dart';

class childWidget2 extends StatefulWidget {

  final Function callback;

  const childWidget2({Key key, this.callback}) : super(key: key);

  @override
  _childWidget2State createState() => _childWidget2State();
}

class _childWidget2State extends State<childWidget2> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      color: Colors.red[100],
      child: Column(
        children: [
          Text('아래에 내용을 입력하세여'),
          TextField(
            onChanged: (value) => widget.callback(value),
          )
        ]
      ),
    );
  }
}
