import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_widget_sample/SAMPLE/TYPECHECK/typeCheck.dart';
import 'package:http/http.dart' as http;


/*
* 동기식으로 사용하려 할때 이용 ex) Result result = await doPost(domainUrl, srestUrl, param);
* return Result / Result.data 안에 모든 리턴데이터 포함되어있음
* */
Future<Result> doPost(String url, Map<String, Object> param) async {
  final storage = new FlutterSecureStorage(); //flutter_secure_storage 사용을 위한 초기화 작업
  String domainUrl = await storage.read(key: "domainUrl"); 
  String at = await storage.read(key: "at");
  Map<String, String> headers = null;
  if(at != null && at != ''){
    headers ={
      "Authorization":"Bearer"+" "+at,
      "Accept":"application/json"
    };
  }else{
    headers = {
      //"Content-Type":"application/json; charset=UTF-8"
      "Accept":"application/json"
    };
  }

  http.Response response = await http.post(
      //Uri.encodeFull(url),
      domainUrl+url,
      headers:headers,
      body:param
      );
  /*print('response.statusCode : ');
  print(response.statusCode);
  print('json.decode(response.body)');
  print(json.decode(response.body));*/
  Result result =  new Result();
  Map<String, dynamic> resultMap = json.decode(response.body);
  if(resultMap.containsKey("DATA")) {
    result.data = resultMap["DATA"];
    result.dataType = typeOf(result.data);
  }else {
    result.data = resultMap;
    result.dataType = '{}';
  }
  if(response.statusCode==200){
    if(resultMap.containsKey("result")) result.result = resultMap["result"].toString();
    else result.result = response.statusCode.toString();
    if(resultMap.containsKey("resultCode")) result.resultCode = resultMap["resultCode"].toString();
    else result.resultCode = response.statusCode.toString();
    if(resultMap.containsKey("resultMessage")) result.resultMessage = resultMap["resultMessage"].toString();
    else result.resultMessage = '';
  }else{
    result.result = '';
    result.resultCode = response.statusCode.toString();
    result.resultMessage = '';
  }

  if(result.result == "401"){ //토큰 갱신 필요
    Map<String, Object> params = {
      "sysareaId":param["sysareaId"],
      "loginUserId":param["id"],
    };
    Result refreshMap = await refreshToken("/authenticate/get_access_token.do", param);
    if(refreshMap.resultCode !="200") return refreshMap;
    else{
      String reat = refreshMap.data["at"].toString();
      await storage.write(//엑세스토큰
          key: "at",
          value: reat
      );
      String rert = refreshMap.data["rt"].toString();
      await storage.write(//리프레시토큰
          key: "rt",
          value: rert
      );
    }
    return await doPost(url, param);
  }
  return result;
}


/*
* 비동기식으로 사용하려 할때 이용 ex) Result result = await doPost(domainUrl, srestUrl, param, callback함수, buildContext);
* buildContext : 프로그래스바 생성을 위해 받음
* Callback 함수 파라미터 : Result
* */
doPostCallback(String url, Map<String, Object> param, BuildContext context, bool ProgressWidgetAble, Function callback) async {

  bool _show = true;
  final storage = new FlutterSecureStorage(); //flutter_secure_storage 사용을 위한 초기화 작업
  String domainUrl = await storage.read(key: "domainUrl");
  if(ProgressWidgetAble == true){
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {

        return StatefulBuilder(
            builder: (context2, StateSetter setState){

              /*Future.delayed(Duration(milliseconds: 500), (){
                try {
                  if(_show == false) Navigator.pop(context2);
                  setState(() {});
                }catch(e){}
            });*/
              return AlertDialog(
                backgroundColor: Color(0xFF9E9E9E),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)
                ),
                content: Container(
                  margin: EdgeInsets.all(0),
                  padding: EdgeInsets.all(0),
                  height: 50,
                  width: 30,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        domainUrl+'/common/images/renewal/progressImg.png',
                      ),
                    ),
                  ),
                  child: Center(
                      child:SizedBox(
                        child:
                        new CircularProgressIndicator(
                            valueColor: new AlwaysStoppedAnimation(Colors.black26),
                            strokeWidth: 5.0
                        ),
                        height: 20.0,
                        width: 20.0,
                      )
                  ),
                ),
              );

            }
        );

      },
    );
  }

  print("Call "+domainUrl+url+"!!!");
  String at = await storage.read(key: "at");
  Map<String, String> headers = null;
  if(at != null && at != ''){
    headers ={
      "Authorization":"Bearer"+" "+at,
      "Accept":"application/json"
    };
  }else{
    headers = {
      //"Content-Type":"application/json; charset=UTF-8"
      "Accept":"application/json"
    };
  }
  http.Response response = await http.post(
    //Uri.encodeFull(url),
      domainUrl+url,
      headers:headers,
      body:param
  );
  Result result =  new Result();
  Map<String, dynamic> resultMap = json.decode(response.body);
  if(resultMap.containsKey("DATA")) {
    result.data = resultMap["DATA"];
    result.dataType = typeOf(result.data);
  }else {
    result.data = resultMap;
    result.dataType = '{}';
  }
  if(response.statusCode==200){
    if(resultMap.containsKey("result")) result.result = resultMap["result"].toString();
    else result.result = response.statusCode.toString();
    if(resultMap.containsKey("resultCode")) result.resultCode = resultMap["resultCode"].toString();
    else result.resultCode = response.statusCode.toString();
    if(resultMap.containsKey("resultMessage")) result.resultMessage = resultMap["resultMessage"].toString();
    else result.resultMessage = '';
  }else{
    result.result = '';
    result.resultCode = response.statusCode.toString();
    result.resultMessage = '';
  }
  if(result.result == "401"){ //토큰 갱신 필요
    Map<String, Object> params = {
      "sysareaId":param["sysareaId"],
      "loginUserId":param["id"],
    };
    print('재발급 가즈아!');
    Result refreshMap = await refreshToken("/authenticate/get_access_token.do", param);
    if(refreshMap.resultCode !="200") {
      _show = false;
      if(ProgressWidgetAble == true) Navigator.pop(context);
      callback(refreshMap);
    }else{
      String reat = refreshMap.data["at"].toString();
      await storage.write(//엑세스토큰
          key: "at",
          value: reat
      );
      String rert = refreshMap.data["rt"].toString();
      await storage.write(//리프레시토큰
          key: "rt",
          value: rert
      );
      print('재발급후 재조회!!!');
      Result res = await doPost(url, param);
      if(ProgressWidgetAble == true) Navigator.pop(context);
      callback(res);
    }
  }else{
    _show = false;
    if(ProgressWidgetAble == true) Navigator.pop(context);
    callback(result);
  }
}

void _dialogCheck(BuildContext context, bool show) {
  if(show == false) Navigator.pop(context);
}

Future<dynamic> refreshToken(String url, Map<String, Object> param) async {

  final storage = new FlutterSecureStorage(); //flutter_secure_storage 사용을 위한 초기화 작업
  String domainUrl = await storage.read(key: "domainUrl");
  String rt = await storage.read(key: "rt");

  http.Response response = await http.post(
    //Uri.encodeFull(url),
      domainUrl+url,
      headers:<String, String>{
        "Authorization":"Bearer"+" "+rt,
        "Accept":"application/json"
      },
      body:param
  );
  print('response.statusCode : ');
  print(response.statusCode);
  print('json.decode(response.body)');
  print(json.decode(response.body));
  Result result =  new Result();
  Map<String, dynamic> resultMap = json.decode(response.body);
  result.data = resultMap;
  result.dataType = '{}';

  if(response.statusCode==200){
    if(resultMap.containsKey("result")) result.result = resultMap["result"].toString();
    else result.result = response.statusCode.toString();
    if(resultMap.containsKey("resultCode")) result.resultCode = resultMap["resultCode"].toString();
    else result.resultCode = response.statusCode.toString();
    if(resultMap.containsKey("resultMessage")) result.resultMessage = resultMap["resultMessage"].toString();
    else result.resultMessage = '';
  }else{
    result.result = '';
    result.resultCode = response.statusCode.toString();
    result.resultMessage = '';
  }
  return result;
}



class Result {
  String result;
  String resultCode;
  String resultMessage;
  dynamic data;
  String dataType;
  Result({this.result, this.resultCode, this.resultMessage, this.data, this.dataType});

  factory Result.fromJson(Map<String, dynamic> json){
    return Result(
      result: json['result'],
      resultCode: json['resultCode'],
      resultMessage: json['resultMessage'],
      dataType: json['dataType'],
      data: json['data'],
    );
  }

  @override
  String toString(){
    String  msg = '-------------------------------------------------------------------------------------------------------------------------------------\n';
    msg += 'RestCall.Result[] \n';
    msg += '\tresult : ${result.toString()} \n';
    msg += '\tresultCode : $resultCode \n';
    msg += '\tresultMessage : $resultMessage \n';
    msg += '\tdataType : $dataType \n';
    msg += '\tdata : $data \n';
    msg += '-------------------------------------------------------------------------------------------------------------------------------------';
    return msg;
  }


}

