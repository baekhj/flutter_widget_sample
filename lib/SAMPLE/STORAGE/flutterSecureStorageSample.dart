import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_widget_sample/SAMPLE/BUTTON/buttonUtil.dart';
import 'package:toast/toast.dart';


/*
flutter_secure_storage: ^4.1.0
 */
class flutterSecureStorageSample extends StatefulWidget {

  final String title;
  final Map<String, dynamic> data;

  flutterSecureStorageSample({this.title, this.data});

  @override
  _flutterSecureStorageSampleState createState() => _flutterSecureStorageSampleState();
}

class _flutterSecureStorageSampleState extends State<flutterSecureStorageSample> {

  TextEditingController keyTxtCtr; //FieldController..
  TextEditingController valueTxtCtr; //FieldController..
  TextEditingController searchTxtCtr; //FieldController..

  List<ListTile> _bodyData = [];

  @override
  void initState() {
    keyTxtCtr = TextEditingController();
    valueTxtCtr = TextEditingController();
    searchTxtCtr = TextEditingController();

    //비동기로 데이터 한번 불러오기 정보를 불러오는 작업.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchAllData();
    });
    
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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  //width: double.infinity,
                  width: MediaQuery.of(context).size.width*0.4,
                  child: TextField(
                    controller: keyTxtCtr,
                    decoration: InputDecoration(
                      labelText: "Key",
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(5)),
                SizedBox(
                  //width: double.infinity,
                  width: MediaQuery.of(context).size.width*0.4,
                  child: TextField(
                    controller: valueTxtCtr,
                    decoration: InputDecoration(
                      labelText: "Value",
                    ),
                  ),
                ),
              ],
            ),


            cancelBottomBtn("저장", 1000, () {
              String key = keyTxtCtr.text.toString();
              String value = valueTxtCtr.text.toString();
              if(key == null || key == '' || value == null || value == ''){
                Toast.show("Key, Value를 모두 입력해 주세요", context, duration: 1, gravity: 1);
                return;
              }
              FltSecStorage fss = new FltSecStorage();
              fss.save(key, value);
              searchAllData();
            }),



            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                SizedBox(
                  //width: double.infinity,
                  width: MediaQuery.of(context).size.width*0.4,
                  child: TextField(
                    controller: searchTxtCtr,
                    decoration: InputDecoration(
                      labelText: "Key",
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(5)),

                okBottomBtn("조회", MediaQuery.of(context).size.width*0.2, () async {
                  String key = searchTxtCtr.text.toString();
                  if(key == null || key == ''){
                    Toast.show("Key를 입력해 주세요", context, duration: 1, gravity: 1);
                    return;
                  }
                  FltSecStorage fss = new FltSecStorage();
                  String value = await fss.getValue(key);
                  _bodyData = [];
                  if(value != null) _bodyData.add(createListTile({"key":key,"value":value}));
                  setState(() {});
                }),

                cancelBottomBtn("삭제", MediaQuery.of(context).size.width*0.2, () {
                  String key = searchTxtCtr.text.toString();
                  if(key == null || key == ''){
                    Toast.show("Key를 입력해 주세요", context, duration: 1, gravity: 1);
                    return;
                  }
                  FltSecStorage fss = new FltSecStorage();
                  fss.delete(key);
                  searchAllData();
                }),
              ],
            ),



            defaultBottomBtn("전체 출력", 1000, searchAllData),

            Container(
              //height: double.infinity,
              height: MediaQuery.of(context).size.height*.5,
              padding: EdgeInsets.all(10),
              child: ListView(
                children: _bodyData,
              ),
            )
          ],
        ),
      ),
    );
  }

  void searchAllData() async {
    FltSecStorage fss = new FltSecStorage();
    Map<String, String> map = await fss.getAllData();
    _bodyData = [];
    map.forEach((key, value) {
      _bodyData.add(createListTile({"key":key,"value":value}));
    });
    setState(() {});
  }

  ListTile createListTile(Map<String, String> data){
    return ListTile(
      title : Row(
        children: [
          Icon(Icons.vpn_key),
          Text(
            data['key'],
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          Icon(Icons.arrow_forward_outlined),
          Text(
            data['value'],
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

}


class FltSecStorage {

  static final storage = new FlutterSecureStorage();

  void save(String key, String value) {
    storage.write(
        key: key
        , value: value
    );
  }
  Future<String> getValue(String key) async {
    String val = await storage.read(key: key);
    return val;
  }
  Future<Map<String, String>> getAllData() async {
    Map<String, String> allData = await storage.readAll();
    return allData;
  }
  void delete(String key){
    storage.delete(key: key);
  }
}
