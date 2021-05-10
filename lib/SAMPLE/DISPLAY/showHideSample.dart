import 'package:flutter/material.dart';
import 'package:flutter_widget_sample/SAMPLE/BUTTON/buttonUtil.dart';


class showHideSample extends StatefulWidget {

  final String title;
  final Map<String, dynamic> data;

  showHideSample({this.title, this.data});

  @override
  _showHideSampleState createState() => _showHideSampleState();

}

class _showHideSampleState extends State<showHideSample> {


  bool show1 = true;
  bool show2 = true;
  bool show3 = true;
  bool show4 = true;
  bool show5 = true;
  bool show6 = true;


  @override
  Widget build(BuildContext context) {
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
              Row(
                children: [
                  createTopBtn('1 - '+show1.toString(), 50, (){
                    setState(() {
                      show1 = !show1;
                    });
                  }),
                  Padding(padding: EdgeInsets.all(5)),
                  createTopBtn('2 - '+show2.toString(), 50, (){
                    setState(() {
                      show2 = !show2;
                    });
                  }),
                  Padding(padding: EdgeInsets.all(5)),
                  createTopBtn('3 - '+show3.toString(), 50, (){
                    setState(() {
                      show3 = !show3;
                    });
                  }),
                  Padding(padding: EdgeInsets.all(5)),
                  createTopBtn('4 - '+show4.toString(), 50, (){
                    setState(() {
                      show4 = !show4;
                    });
                  }),
                  Padding(padding: EdgeInsets.all(5)),
                  createTopBtn('5 - '+show5.toString(), 50, (){
                    setState(() {
                      show5 = !show5;
                    });
                  }),
                  Padding(padding: EdgeInsets.all(5)),
                  createTopBtn('6 - '+show6.toString(), 50, (){
                    setState(() {
                      show6 = !show6;
                    });
                  }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedOpacity(
                    opacity: show1?1:0,
                    duration: Duration(milliseconds: 1000),
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.2,
                      width: MediaQuery.of(context).size.width*0.5,
                      color: Colors.grey,
                      child: Column(
                          children: [
                            Text('1 - AnimatedOpacity'),
                            Text('자리 차지..'),
                          ]
                      ),
                    ),
                  ),
                  Visibility(
                    visible: show2,
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.2,
                      width: MediaQuery.of(context).size.width*0.5,
                      color: Colors.red[100],
                      child: Text('2 - Visibility'),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Visibility(
                    visible: show3,
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.2,
                      width: MediaQuery.of(context).size.width*0.5,
                      color: Colors.green,
                      child: Text('3 - Visibility'),
                    ),
                  ),
                  Visibility(
                    visible: show4,
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.2,
                      width: MediaQuery.of(context).size.width*0.5,
                      color: Colors.blueGrey[100],
                      child: Text('4 - Visibility'),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height*0.2,
                    width: MediaQuery.of(context).size.width*0.5,
                    color: Colors.amber,
                    child: Text('5'),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height*0.2,
                    width: MediaQuery.of(context).size.width*0.5,
                    color: Colors.blueAccent[100],
                    child: Text('6'),
                  ),
                ],
              ),

            ],
          ),
      ),
    );
  }
}
