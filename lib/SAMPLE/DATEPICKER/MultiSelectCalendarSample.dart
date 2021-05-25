import 'package:flutter/material.dart';
import 'package:flutter_widget_sample/SAMPLE/BUTTON/buttonUtil.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart' as intl;
import 'package:toast/toast.dart';

class MultiSelectCalendarSample extends StatefulWidget {

  final String title;
  final Map<String, dynamic> data;

  const MultiSelectCalendarSample({Key key, this.title, this.data}) : super(key: key);

  @override
  _MultiSelectCalendarSampleState createState() => _MultiSelectCalendarSampleState();
}

class _MultiSelectCalendarSampleState extends State<MultiSelectCalendarSample> {


  int curIdx = 0;

  DateRangePickerController dateCtr;

  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';
  DateTime selectedDate;
  List<DateTime> selectedDates;
  PickerDateRange selectedRange;
  List<PickerDateRange> selectedRanges;
  List<Map<String, dynamic>> list = [
    {'title':'연차', 'subtitle':'오전반차', 'progCd':'DAL-0005',"calType":DateRangePickerSelectionMode.single},
    {'title':'연차', 'subtitle':'오후반차', 'progCd':'DAL-0005',"calType":DateRangePickerSelectionMode.single},
    {'title':'연차', 'subtitle':'종일', 'progCd':'DAL-0005',"calType":DateRangePickerSelectionMode.range},
    {'title':'시간외(사전)신청', 'subtitle':'퇴근후1시간', 'progCd':'DAL-0102',"calType":DateRangePickerSelectionMode.multiple},
    {'title':'시간외(사전)신청', 'subtitle':'퇴근후2시간', 'progCd':'DAL-0102',"calType":DateRangePickerSelectionMode.multiple},
    {'title':'시간외(사후)신청', 'subtitle':'퇴근후1시간', 'progCd':'DAL-0101',"calType":DateRangePickerSelectionMode.multiple},
    {'title':'시간외(사후)신청', 'subtitle':'퇴근후2시간', 'progCd':'DAL-0101',"calType":DateRangePickerSelectionMode.multiple},
    {'title':'출장신청', 'subtitle':'당일출근', 'progCd':'DAL-2200',"calType":DateRangePickerSelectionMode.multiRange},
    {'title':'출장신청', 'subtitle':'당일퇴근', 'progCd':'DAL-2200',"calType":DateRangePickerSelectionMode.multiRange},
  ];

  @override
  void initState() {
    print("SimpleApproval Init!");
    super.initState();

    dateCtr = DateRangePickerController();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      //_approPageInfo(true); //페이지 정보
    });

  }

  @override
  Widget build(BuildContext context) {
    print('Build SimpleApproval!!');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color(0xff13A2A3),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 20, left: 10,bottom: 0,),
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    '선택 : '+list[curIdx]['title']+'('+list[curIdx]['subtitle']+')',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black45,
                    ),
                    textAlign: TextAlign.left,
                  ),
                )
              ),
              Container(
                //margin: EdgeInsets.symmetric(vertical: 20.0), //화면위아래 마진
                margin: EdgeInsets.only(bottom: 20,),
                padding: EdgeInsets.only(left: 5, right: 5,),
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal, //수평스크롤 설정
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black38,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      width: 150,
                      child: ListTile(
                        selectedTileColor: const Color(0xff13A2A3),
                        selected: index==curIdx?true:false,
                        //title: Text(list[index]['title']),
                        title: Text(
                          list[index]['title'],
                          style: TextStyle(
                            fontSize: 15,
                            color: index==curIdx?Colors.white:Colors.black,
                            fontWeight:FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          list[index]['subtitle'],
                          style: TextStyle(
                            fontSize: 13,
                            color: index==curIdx?Colors.white:Colors.black,
                          ),
                        ),
                        onTap: () {
                          curIdx = index;
                          _selectedDate = '';
                          _dateCount = '';
                          _range = '';
                          _rangeCount = '';
                          selectedDate = null;
                          selectedDates = null;
                          selectedRanges = null;
                          selectedRange = null;
                          dateCtr = DateRangePickerController();  //근무일정 선택시 캘린더 초기화용
                          dateCtr.view = dateCtr.view;
                          print(curIdx);
                          setState(() {});
                        },
                      ),
                    );
                  },
                ),
              ),


              Container(
                child: SfDateRangePicker(

                  onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                    print(args.value.toString());
                    if (args.value is PickerDateRange) {
                      dateCtr.selectedRange = args.value;
                      _range = intl.DateFormat('yyyy-MM-dd').format(args.value.startDate) +' - ' +
                          intl.DateFormat('yyyy-MM-dd').format(args.value.endDate ?? args.value.startDate).toString();
                    } else if (args.value is DateTime) {
                      dateCtr.selectedDate = args.value;
                      _selectedDate = args.value.toString();
                    } else if (args.value is List<DateTime>) {
                      dateCtr.selectedDates = args.value;
                      _dateCount = args.value.length.toString();
                    } else {
                      dateCtr.selectedRanges = args.value;
                      _rangeCount = args.value.length.toString();
                    }
                    setState(() {});
                  },
                  //selectionMode: DateRangePickerSelectionMode.multiple,
                  //selectionMode: DateRangePickerSelectionMode.range,
                  //selectionMode: DateRangePickerSelectionMode.multiRange,
                  //selectionMode: DateRangePickerSelectionMode.single,
                  selectionMode: list[curIdx]['calType'],
                  /*initialSelectedDate: DateTime.now(),
                  initialSelectedDates: [],
                  initialSelectedRanges: [],
                  initialSelectedRange: PickerDateRange(
                    DateTime.now().subtract(const Duration(days: 4)),
                    DateTime.now().add(const Duration(days: 3))
                  ),*/

                  controller: dateCtr,
                  /*initialSelectedDate: selectedDate,
                  initialSelectedDates: selectedDates,
                  initialSelectedRanges: selectedRanges,
                  initialSelectedRange: selectedRange,*/
                  allowViewNavigation: true,
                  showNavigationArrow: true,


                ),
              ),

              Container(
                padding: EdgeInsets.only(top: 20, left: 10,bottom: 0,),
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    getDateStr(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black45,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),

              Padding(
                  padding: EdgeInsets.all(10)
              ),

              okBottomBtn("신청", 100, (){
                Toast.show("신청 프로세스 가즈아",context,duration: 1,gravity: 1);
                if(_checkVac() == false) return;
                _simpleReqst();
              }),

            ],
          ),
        ),
      ),
    );
  }

  String getDateStr(){
    String str ='';
    if(list[curIdx]['calType'] == DateRangePickerSelectionMode.single){
      if(dateCtr.selectedDate != null){
        str = intl.DateFormat('yyyy-MM-dd').format(dateCtr.selectedDate);
      }
    }else if(list[curIdx]['calType'] == DateRangePickerSelectionMode.multiple){
      if(dateCtr.selectedDates != null){
        dateCtr.selectedDates.sort((sTm, eTm){
          return sTm.compareTo(eTm);
        });
        dateCtr.selectedDates.forEach((element) {
          str += ''+intl.DateFormat('yyyy-MM-dd').format(element)+', ';
        });
        str = str.substring(0, str.lastIndexOf(","));
        str = '\n'+str;
      }
    }else if(list[curIdx]['calType'] == DateRangePickerSelectionMode.range){
      if(dateCtr.selectedRange != null){
        str = intl.DateFormat('yyyy-MM-dd').format(dateCtr.selectedRange.startDate)
            + (dateCtr.selectedRange.endDate != null?' ~ ' +intl.DateFormat('yyyy-MM-dd').format(dateCtr.selectedRange.endDate):'');
      }

    }else if(list[curIdx]['calType'] == DateRangePickerSelectionMode.multiRange){
      if(dateCtr.selectedRanges != null){
        dateCtr.selectedRanges.sort((sRan, eRan){
          return sRan.startDate.compareTo(eRan.startDate);
        });
        dateCtr.selectedRanges.forEach((element) {
          str += '\n '+intl.DateFormat('yyyy-MM-dd').format(element.startDate)
              + (element.endDate != null?' ~ ' +intl.DateFormat('yyyy-MM-dd').format(element.endDate):'');
        });
      }
    }
    if(str!='') str = '일정 : '+str;
    return str;
  }

  bool _checkVac(){
    if(1==1){
      return false;
    }
    return true;
  }

  void _simpleReqst(){
  }
}
