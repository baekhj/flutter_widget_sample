import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

//pubspec.yml 에
// flutter_localizations:
//     sdk: flutter
// 추가하고, 만약 intl, chart_flutter 사용하고있다면 아래사항으로 버전업해줘야함
// intl: ^0.17.0
// charts_flutter: ^0.10.0
// 그리고 main.dart MaterialApp 에
//        localizationsDelegates: [
//         GlobalMaterialLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate
//       ],
//       supportedLocales: [
//         const Locale('ko','KR',)
//       ],
// 내역 추가하여 한국시간 기준 셋팅

//컨트롤러에 날짜값 셋팅
Future<DateTime> selectDateCallback(BuildContext context, TextEditingController controller, Function callback) async {
  FocusScopeNode currentFocus = FocusScope.of(context);
  currentFocus.unfocus();
  String fieldDate = controller.text;
  DateTime selectedDate = null;
  if(fieldDate != ''){
    try {
      selectedDate = DateTime.parse(fieldDate);
    }catch(e){
      selectedDate = DateTime.now();
    }
  }else{
    selectedDate = DateTime.now();
  }
  final DateTime picked = await showDatePicker(
    context: context,
    initialDate: selectedDate, // Refer step 1
    firstDate: DateTime(2000),
    lastDate: DateTime(2999),
    initialEntryMode: DatePickerEntryMode.calendar,
  );
  if(picked != null){
    selectedDate = picked;
    String stringDate = intl.DateFormat('yyyy-MM-dd').format(picked);
    print(stringDate);
    controller.text = stringDate;
    callback(stringDate);
  }
  return null;
}

//날짜호출용 위젯
//context, controller, labelText 를 매개변수로 전달

Widget select_calendarCallback(BuildContext context,TextEditingController controller, InputDecoration deco , Function callback){
  return Container(
    /*decoration: BoxDecoration(
        border: Border.all(color:Colors.black12),
        borderRadius: BorderRadius.all(Radius.circular(20))
    ),*/
    width: 140,
    height: 40,
    child: Padding(
      padding: EdgeInsets.only(left:20,top:8),
      child: Form(
        child: TextFormField(
          controller: controller,
          textAlign:TextAlign.center,
          decoration:  deco,
          // onTap: () => selectStaDate(context),
          onTap: () => selectDateCallback(context,controller, callback),
          // validator: (String value) {
          //   if (value.isEmpty) {
          //     return "Plesase input date";
          //   }
          //   return null;
          // },
        ),
      ),
    ),
  );
}

