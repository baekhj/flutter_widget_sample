import 'package:flutter/material.dart';
import 'package:flutter_widget_sample/SAMPLE/AES/aesScryptoJSUtil.dart';
import 'package:flutter_widget_sample/SAMPLE/AES/mathUtil.dart';
import 'package:flutter_widget_sample/SAMPLE/BUTTON/buttonUtil.dart';
import 'package:toast/toast.dart';

class aesScryptoJSSample extends StatefulWidget {

  final String title;
  final Map<String, dynamic> data;

  aesScryptoJSSample({this.title, this.data});

  @override
  _aesScryptoJSSampleState createState() => _aesScryptoJSSampleState();
}

class _aesScryptoJSSampleState extends State<aesScryptoJSSample> {

  TextEditingController txtCtr; //FieldController..
  TextEditingController keyTxtCtr; //FieldController..
  TextEditingController encTxtCtr; //FieldController..
  TextEditingController decTxtCtr; //FieldController..

  @override
  void initState() {
    super.initState();
    txtCtr = TextEditingController();
    encTxtCtr = TextEditingController();
    keyTxtCtr = TextEditingController();
    decTxtCtr = TextEditingController();
  }

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
           TextField(
             controller: txtCtr,
             decoration: InputDecoration(labelText: "암호화할 문자"),
           ),
           cancelBottomBtn("aesScrypto 암호화", 1000, () {
              String txt = txtCtr.text.toString();
              if(txt == null || txt == ''){
                Toast.show("문자열을 입력해 주세요", context, duration: 1, gravity: 1);
                return;
              }

              String sKey = generateRandomString(10); //암복호화 공용키 - 10자리..
              keyTxtCtr.text = sKey;
              String encStr = encryptAESCryptoJS(txt, sKey);
              encTxtCtr.text = encStr;
              decTxtCtr.text = '';
           }),
           TextField(
             controller: keyTxtCtr,
             decoration: InputDecoration(labelText: "암호화키"),
           ),
           TextField(
             controller: encTxtCtr,
             decoration: InputDecoration(labelText: "암호화된 문자"),
           ),
           defaultBottomBtn("aesScrypto 복호화", 1000, () {
             String keyTxt = keyTxtCtr.text.toString();
             if(keyTxt == null || keyTxt == ''){
               Toast.show("암호화 키가 없습니다.", context, duration: 1, gravity: 1);
               return;
             }
             String encTxt = encTxtCtr.text.toString();
             if(encTxt == keyTxt || encTxt == ''){
               Toast.show("암호화된 문자열이 없습니다.", context, duration: 1, gravity: 1);
               return;
             }
             String resValue = decryptAESCryptoJS(encTxt, keyTxt);
             decTxtCtr.text = resValue;
           }),
           TextField(
             controller: decTxtCtr,
             decoration: InputDecoration(labelText: "복호화된 문자"),
           ),
         ],
       ),
      ),
    );
  }
}
