import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_widget_sample/SAMPLE/BUTTON/buttonUtil.dart';
import 'package:flutter_widget_sample/SAMPLE/REST/restCallUtil.dart';
import 'package:toast/toast.dart';

class restCallSample extends StatefulWidget {

  final String title;
  final Map<String, dynamic> data;

  restCallSample({this.title, this.data});

  @override
  _restCallSampleState createState() => _restCallSampleState();
}

class _restCallSampleState extends State<restCallSample> {

  final methodList = ["POST", "GET", "PUT", "DELETE"];
  String methodStr;
  String resultStr='';
  TextEditingController domainCtr; //FieldController..
  TextEditingController txtCtr; //FieldController..

  @override
  void initState() {
    super.initState();
    domainCtr = TextEditingController();
    txtCtr = TextEditingController();
    methodStr = methodList[0];

    /*
    SampleUrl
    https://reqres.in/api/products
    http://dummy.restapiexample.com/api/v1/employees  => 간헐적 429발생..요청이 많나봐..
    */
    domainCtr.text='http://dummy.restapiexample.com';
    txtCtr.text = '/api/v1/employees';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,  //키보드 클릭시 overflowed 발생할때 넣어주면  키보드 올라와도 화면을 위로 올리지 않음
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ),
      body: Column(
        children: [
          TextField(
            controller: domainCtr,
            decoration: InputDecoration(labelText: "Domain URL"),
          ),
          Row(
            children : [
              Padding(padding: EdgeInsets.all(5)),
              DropdownButton(
                value: methodStr,
                items: methodList.map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child:  Text(
                      e,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black45,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  methodStr = value;
                },
                //hint: Text("dis!"),
                disabledHint: Text('-'),
                //style: Theme.of(context).textTheme.title,
              ),
              Padding(padding: EdgeInsets.all(10)),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.65,
                child: TextField(
                  controller: txtCtr,
                  decoration: InputDecoration(labelText: "Call URL"),
                ),
              ),
            ]
          ),
          defaultBottomBtn("REST Call", 100, () async {
            Map<String, Object> param = {
            };
            String domainUrl = domainCtr.text.toString();
            if(domainUrl==''){
              Toast.show('Domain URL을 입력해 주세요.', context, duration: 1, gravity: 1);
              return false;
            }
            final storage = new FlutterSecureStorage(); //flutter_secure_storage 사용을 위한 초기화 작업
            await storage.write(key: "domainUrl", value: domainUrl);

            String url = txtCtr.text.toString();
            if(url==''){
              Toast.show('URL을 입력해 주세요.', context, duration: 1, gravity: 1);
              return false;
            }
            doRestCallback(url, methodStr, param, context, true, (res){
              resultStr = res.toString();
              setState(() {});
              if(res.dataType == "{}"){
                Map<String, dynamic> resultData = res.data;
                var keys = resultData.keys;
                for(var i=0; i <keys.length; i++){
                  print("\t"+ keys.elementAt(i)+" : "+resultData[keys.elementAt(i)].toString());
                }
              }else if(res.dataType == "[]"){
                List<dynamic> resultData = res.data;
                for(var i=0; i < resultData.length; i++){
                  print("\t index"+i.toString()+" : "+resultData[i].toString());
                }
              }
            });

          }),
          Container(
            //height: double.infinity, //MediaQuery.of(context).size.height*0.5,
            height: MediaQuery.of(context).size.height*0.65,
            width: double.infinity,
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Result :",
                    //overflow: TextOverflow.visible,
                  ),
                  Text(resultStr),
                ],
              ),
            ),
          )
        ],
      ),
    );
    /*return Container(
      child: Image.network(
          'http://kbbank-dev.arainhr.com/ImageDownload.do?savePath=arainFiles/112/cprPic//&saveFile=(6234)logo_arain.png&fileSeq=6234&seq=1&callType=pkg&saveType=F&random=133.5407751444122',
      ),
    );*/
  }
}
