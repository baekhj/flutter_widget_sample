import 'package:flutter/material.dart';

class childWidget1 extends StatefulWidget {

  final Function callback;

  const childWidget1({Key key, this.callback}) : super(key: key);

  @override
  _childWidget1State createState() => _childWidget1State();
}

class _childWidget1State extends State<childWidget1> {

  TextEditingController txtCtr;

  @override
  void initState() {
    super.initState();
    txtCtr = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.green[100],
        child: Column(
            children: [
              Text('아래에 내용을 입력하세여'),
              TextField(
                controller: txtCtr,

              ),
              RaisedButton(
                onPressed: () {
                  widget.callback(txtCtr.text);
                  Navigator.pop(context);
                },
                child: Text('저장'),
              ),
            ]
        ),
      ),
    );
  }
}
