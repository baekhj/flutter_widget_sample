import 'package:flutter/material.dart';

class TextWidgetSample extends StatefulWidget {

  final String title;
  final Map<String, dynamic> data;

  TextWidgetSample({this.title, this.data});

  @override
  _TextWidgetSampleState createState() => _TextWidgetSampleState();
}

class _TextWidgetSampleState extends State<TextWidgetSample> {
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
            // 색상
            Text(
              'Blue Color [색상]',
              style: TextStyle(color: Colors.blue),
            ),
            // 색상과 불투명도
            Text(
              'Blue Color With Opacity [색상과 불투명도]',
              style: TextStyle(color: Colors.blue.withOpacity(0.5)),
            ),
            // 굵기
            Text(
              'Bold [굵기]',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            // 이탤릭체
            Text(
              'Italic [이탤릭체]',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            // 텍스트 크기
            Text(
              '26 Size [폰트사이즈]',
              style: TextStyle(fontSize: 26),
            ),
            // 텍스트 행간
            Text(
              'line height [텍스트행간-줄간격]',
              style: TextStyle(fontSize: 20, height: 7),
            ),

            Container(
              width: 1000,
              child: Text('Left [정렬 - left 왼쪽]', textAlign: TextAlign.left),
            ),
            Container(
              width: 1000,
              child: Text('center [정렬 - center 가운데]', textAlign: TextAlign.center),
            ),
            Container(
              width: 1000,
              child: Text('Right [정렬 - right 오른쪽]', textAlign: TextAlign.right),
            ),
            Container(
              width: 1000,
              child: Text('Start [정렬 - start 시작점?]', textAlign: TextAlign.start),
            ),
            Container(
              width: 1000,
              child: Text('End [정렬 - end 끝점?]', textAlign: TextAlign.end),
            ),
            Container(
              width: 1000,
              child: Text('Justify [정렬 - Justify]', textAlign: TextAlign.justify),
            ),

            Container(
              width: 1000,
              child: Text('ltr Direction [텍스트방향 ltr]', textDirection: TextDirection.ltr),
            ),
            Container(
              width: 1000,
              child: Text('rtl Direction [텍스트방향 rtr]', textDirection: TextDirection.rtl),
            ),


            Text.rich(
              TextSpan(
                text: 'Hello', // default text style
                children: <TextSpan>[
                  TextSpan(
                      text: ' beautiful ',
                      style: TextStyle(fontStyle: FontStyle.italic)
                  ),
                  TextSpan(
                      text: 'world',
                      style: TextStyle(fontWeight: FontWeight.bold)
                  ),
                  TextSpan(
                      text: ' [한줄에 여러 Style 가진 텍스트]',
                  ),
                ],
              ),
            ),



            Container(
              width: 1000,
              height: 20,
              child: Text(
                'Hello World [레이아웃OVER - 자름]', overflow: TextOverflow.clip,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              width: 1000,
              child: Text(
                'Hello World [레이아웃OVER - 줄임표기]', overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            Container(
              width: 1000,
              height: 20,
              child: Text(
                'Hello World [레이아웃OVER - 불투명]', overflow: TextOverflow.fade,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              width: 1000,
              height: 20,
              child: Text(
                'Hello World [레이아웃OVER - 전부표기]', overflow: TextOverflow.visible,
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
