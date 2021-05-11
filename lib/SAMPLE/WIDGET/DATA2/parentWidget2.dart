import 'package:flutter/material.dart';
import 'package:flutter_widget_sample/SAMPLE/WIDGET/DATA2/DataVO.dart';
import 'package:flutter_widget_sample/SAMPLE/WIDGET/DATA2/childWidget2.dart';
import 'package:intl/intl.dart' as intl;

class ParentWidget2 extends StatefulWidget {

  final String title;
  final Map<String, dynamic> data;

  const ParentWidget2({Key key, this.title, this.data}) : super(key: key);

  @override
  _ParentWidget2State createState() => _ParentWidget2State();
}

class _ParentWidget2State extends State<ParentWidget2> {

  int curUserIdx=0;
  List<DataVO> list = [];
  DataVO vo;

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height*0.6,
          child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.all(5)),
                    Text('데이터 ('+list.length.toString()+')'),
                    Padding(padding: EdgeInsets.all(5)),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.55,
                      //height: 100,
                      //height: double.infinity,
                      child: ListView.separated(
                        padding: EdgeInsets.all(0),
                        itemBuilder: (context, index) {
                          var textStyle = TextStyle(
                            fontSize: 13,
                          );
                          if(list.length == 0){
                            return ListTile(
                              title: Text('추가해 주세요',
                                style: textStyle,
                              ),
                            );
                          }
                          return ListTile(

                            contentPadding: EdgeInsets.only(
                              left: 0,
                              top: 5,
                              right: 0,
                              bottom: 0,
                            ),
                            title: Row(
                              children: [
                                //Text('No.'+userList[index]['sNo'], style: textStyle,),
                                Text('No.'+list[index].no .toString(), style: textStyle,),
                                Padding(padding: EdgeInsets.all(5)),
                                Text(''+intl.DateFormat('yyyy-MM-dd').format(DateTime.parse(list[index].ymd)), style: textStyle,),

                              ],
                            ),
                            subtitle: Container(
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Padding(padding: EdgeInsets.all(5)),
                                  Text(''+list[index].str, style: textStyle,),
                                  Padding(padding: EdgeInsets.all(10)),
                                  Text(''+list[index].bigo, style: textStyle,),
                                ],
                              ),
                            ),
                            onTap: () {
                              showDialog(context: context, builder: (context) => childWidget2(list[index], updateCallback),);

                            },
                          );
                        },
                        itemCount: list.length==0?1:list.length,
                        //itemCount: 10,
                        separatorBuilder: (context, index) => Divider(),
                      ),

                    ),

                    Padding(padding: EdgeInsets.all(9)),
                  ],
                ),


                Container(
                  width: double.infinity,
                  //height: double.infinity,
                  height: 20,
                  alignment: Alignment.topRight,
                  padding: EdgeInsets.all(0),
                  margin: EdgeInsets.all(10),
                  child: SizedBox(
                    width: 70,
                    height: 20,
                    child: RaisedButton(
                      child: Text(
                        '추가',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                      onPressed: () {
                        vo = new DataVO();
                        vo.ymd = intl.DateFormat('yyyyMMdd').format(DateTime.now());   //기본값 오늘
                        vo.isFirstReg = 'Y';
                        vo.no = (list.length+1).toString();
                        curUserIdx=list.length+1;
                        showDialog(context: context, builder: (context) => childWidget2(vo, updateCallback),);
                      },
                      color: Colors.white30,
                    ),
                  ),
                ),

              ]
          ),
          width: 1000,
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          decoration: lineDecoration(),
        ),
      ),
    );
  }

  Function updateCallback(DataVO data){
    setState(() {
      if(this.vo.isFirstReg =='Y'){
        this.vo.isFirstReg = 'N';
        list.add(this.vo);
      }
    });
  }


  BoxDecoration lineDecoration(){
    return BoxDecoration(
      border: Border(
        top: BorderSide(
          color: Colors.grey[300],
          width: 1.0,
        ),
        right: BorderSide(
          color: Colors.grey[300],
          width: 1.0,
        ),
        bottom: BorderSide(
          color: Colors.grey[300],
          width: 1.0,
        ),
        left: BorderSide(
          color: Colors.grey[300],
          width: 1.0,
        ),
      ),
      borderRadius: new BorderRadius.circular(7),
      color: Colors.grey[200],
    );
  }

}

