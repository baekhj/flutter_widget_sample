import 'dart:convert';

import 'package:flutter_widget_sample/SAMPLE/TYPECHECK/typeCheck.dart';

import 'SampleData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_treeview/tree_view.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter_treeview/generated/i18n.dart';


/*
# 깃헙 어디 참조했는데 어디인지 기억이 안나요.. 죄송합니다...
flutter_treeview: ^0.9.0+1  #조직도용
 */

class OrgChart extends StatefulWidget {

  final String title;
  final Map<String, dynamic> data;

  const OrgChart({Key key, this.title, this.data}) : super(key: key);

  @override
  _OrgChartState createState() => _OrgChartState();
}

class _OrgChartState extends State<OrgChart> {

  String _selectedNode;
  TreeViewController _treeViewController;
  bool docsOpen = true;
  bool deepExpanded = true;
  bool _allowParentSelect = false;
  bool _supportParentDoubleTap = false;

  TextEditingController searchController;

  @override
  void initState() {
    searchController = TextEditingController();
    _treeViewController = TreeViewController(
      children: [],
      selectedKey: _selectedNode,
    );
    _treeViewController = _treeViewController.loadJSON(json: US_STATES_JSON);

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      //_OrgDataData(true); //페이지 정보 - 서버에서 가져온 데이터 사용할때...
    });
  }

/*

  void _OrgDataData(bool Progress) async {
    DateTime a = DateTime.now();
    Map<String, Object> approParam = {
      "searchSymd":intl.DateFormat('yyyy-MM-dd').format(a),
    };
    doPostCallback('/MgrOrgnztPerson2.do?cmd=getMgrOrgnztPersonAllList', approParam, context, Progress, _OrgDataDataCallback);
  }

  void _OrgDataDataCallback(Result res){
    print(res.data);
    setState(() {
      //_treeViewController = _treeViewController.loadJSON(json: jsonEncode(convertNodeData(res.data, null)));
      _treeViewController = TreeViewController(
        children: convertNodeToMap(convertNodeData(res.data, null)),
        selectedKey: _selectedNode,
      );
    });
  }
*/

  List<dynamic> treeDataList = [];  //리스트로 된 전체 데이터
  List<dynamic> searchData = [];  //검색결과담긴 아이들
  int searchIdx=0;

  List<dynamic> convertNodeData(dynamic data, dynamic pObj){
    List<dynamic> res = [];
    List<dynamic> dataList;
    if(typeOf(data) == '[]'){
      dataList = data;
      dynamic dtail;
      if(pObj == null)treeDataList.insertAll(0, dataList);
      for(int i=0; i<dataList.length; i++){
        dtail = dataList[i];
        if((pObj == null && dtail['priorOrgCd'] == '0') || (pObj != null && dtail['priorOrgCd'] == pObj['orgCd'])){
          //dtail['key'] = (dtail['orgType']=='D'?dtail['orgCd']:dtail['orgCd']+"_"+dtail['empId']);
          dtail['key'] = (dtail['orgType']=='D'?dtail['orgCd']:dtail['priorOrgCd']+"_"+dtail['empId']);
          dtail['label'] = (dtail['orgType']=='D'?dtail['orgNm']:dtail['empNm']);
          dtail['fullPath'] = (pObj==null?'':pObj['fullPath'])+" "+(dtail['orgType']=='D'?dtail['orgNm']:dtail['empNm']);
          dtail['data'] = jsonEncode(dtail);
          dtail['children'] = [];
          res.add(dtail);
        }
      }
      dataList.removeWhere((element) {return element['priorOrgCd']==(pObj==null?'0':pObj['orgCd']);});
      res.forEach((element) {
        element['children'] = convertNodeData(dataList, element);
      });
    }
    return res;
  }

  List<Node> convertNodeToMap(List<dynamic> list){
    List<Node> nodeList = [];
    list.forEach((element) {
      nodeList.add(makeNode(element));
    });
    return nodeList;
  }

  Node makeNode(Map<String, dynamic> data){
    List<dynamic> children = [];
    List<Node> childrenNode = [];
    if(data.containsKey('children')){
      children = data['children'];
      childrenNode = [];
      children.forEach((element) {
        childrenNode.add(makeNode(element));
      });
    }
    Node nd = Node(
      key: data['key'],
      label: data['label'],
      data: data['data'],
      icon: getIcon(data),
      children: childrenNode,
    );
    return nd;
  }

  IconData getIcon(Map<String, dynamic> data){
    IconData ic = null;
    if(data['priorOrgCd']=='0') ic = Icons.apartment;
    else if(data['orgType']=='D') ic = Icons.account_tree_outlined;
    else if(data['orgType']=='U' && data['detailSeq']=='1') ic = Icons.account_circle_outlined;
    else if(data['orgType']=='U' ) ic = Icons.account_circle_rounded;
    return ic;
  }

  void setSearchData(int idx){
    if(searchData.length>0){
      _selectedNode = searchData[idx]['orgCd'];
      List<Node> newdata = _treeViewController.expandToNode(_selectedNode);
      _treeViewController =_treeViewController.copyWith(children: newdata);
      if(_treeViewController.getNode(_selectedNode).children.length==0) _treeViewController =_treeViewController.copyWith(selectedKey: _selectedNode);
    }else{
      _treeViewController = _treeViewController.withCollapseAll();
    }
    setState(() {});
  }



  @override
  Widget build(BuildContext context) {
    TreeViewTheme _treeViewTheme = TreeViewTheme( //트리스타일지정
      expanderTheme: ExpanderThemeData(
          type: ExpanderType.plusMinus,
          modifier: ExpanderModifier.none,
          position: ExpanderPosition.end,
          // color: Colors.grey.shade800,
          size: 15,
          color: Colors.blue),
      labelStyle: TextStyle(
        fontSize: 13,
        letterSpacing: 0.3,
      ),
      parentLabelStyle: TextStyle(
        fontSize: 13,
        letterSpacing: 0.1,
        fontWeight: FontWeight.w800,
        //color: Colors.blue.shade700,
        color: Colors.black,
      ),
      iconTheme: IconThemeData(
        size: 18,
        color: Colors.grey.shade800,
      ),
      colorScheme: Theme.of(context).colorScheme,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          padding: EdgeInsets.all(20),
          height: double.infinity,
          child: Column(
            children: <Widget>[
              Container(
                height: 60,
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(Icons.navigate_before),
                            onPressed: () {
                              if(searchIdx-1<0)return;
                              else {
                                setSearchData(--searchIdx);
                              }
                            },
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.6,
                            child: TextField(
                              controller: searchController,
                              onChanged: (value) {

                                //_treeViewController. collapseAll();
                                //return;
                                searchIdx=0;
                                searchData = [];
                                //print(treeDataList);
                                treeDataList.forEach((element) {
                                  if(value!='' && element['orgFullNm'].toString().contains(value)){
                                    searchData.add(element);
                                  }
                                });
                                setSearchData(searchIdx);

                                //print("change : "+value+' / '+searchData.toString()+'/ '+searchData[searchIdx]['orgCd']);

                              },
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.navigate_next_rounded),
                            onPressed: () {
                              if(searchIdx+1>searchData.length-1)return;
                              else {
                                setSearchData(++searchIdx);
                              }
                            },
                          ),
                        ]
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(5),
                  child: TreeView(
                    controller: _treeViewController,
                    allowParentSelect: _allowParentSelect,
                    supportParentDoubleTap: _supportParentDoubleTap,
                    onExpansionChanged: (key, expanded) {
                      _selectedNode = key;
                      _expandNode(key, expanded);
                      //print(_treeViewController.getNode(key).toString());
                      //print(_treeViewController.getNode(key).data);
                      //print(treeDataList);
                      //print(_selectedNode);

                    },
                    onNodeTap: (key) {
                      //debugPrint('Selected: $key');
                      //print(_treeViewController.getNode(key).toString());
                      debugPrint(_treeViewController.getNode(_selectedNode).data);
                      setState(() {
                        _selectedNode = key;
                        //print(_selectedNode);
                        //print(_treeViewController.getNode(_selectedNode).data);
                        _treeViewController = _treeViewController.copyWith(selectedKey: key);
                      });
                    },
                    theme: _treeViewTheme,

                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  debugPrint('Close Keyboard');
                  FocusScope.of(context).unfocus();
                },
                child: Container(
                  padding: EdgeInsets.only(top: 20),
                  alignment: Alignment.center,
                  child: Text(
                    (
                        _treeViewController.getNode(_selectedNode) == null
                            ? ''
                            //: jsonDecode(_treeViewController.getNode(_selectedNode).data)['fullPath'] //선택된 데이터(서버에서 가져오고처리)
                            : _treeViewController.getNode(_selectedNode).label
                    ),
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _expandNode(String key, bool expanded) {
    String msg = '${expanded ? "Expanded" : "Collapsed"}: $key';
    debugPrint(msg);
    Node node = _treeViewController.getNode(key);
    print(node);
    if (node != null) {
      List<Node> updated;
        updated = _treeViewController.updateNode(key, node.copyWith(expanded: expanded));
      setState(() {
        _treeViewController = _treeViewController.copyWith(children: updated);
      });
    }
  }
}



class ModContainer extends StatelessWidget {
  final ExpanderModifier modifier;

  const ModContainer(this.modifier, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _borderWidth = 0;
    BoxShape _shapeBorder = BoxShape.rectangle;
    Color _backColor = Colors.transparent;
    Color _backAltColor = Colors.grey.shade700;
    switch (modifier) {
      case ExpanderModifier.none:
        break;
      case ExpanderModifier.circleFilled:
        _shapeBorder = BoxShape.circle;
        _backColor = _backAltColor;
        break;
      case ExpanderModifier.circleOutlined:
        _borderWidth = 1;
        _shapeBorder = BoxShape.circle;
        break;
      case ExpanderModifier.squareFilled:
        _backColor = _backAltColor;
        break;
      case ExpanderModifier.squareOutlined:
        _borderWidth = 1;
        break;
    }
    return Container(
      decoration: BoxDecoration(
        shape: _shapeBorder,
        border: _borderWidth == 0
            ? null
            : Border.all(
          width: _borderWidth,
          color: _backAltColor,
        ),
        color: _backColor,
      ),
      width: 15,
      height: 15,
    );
  }
}
