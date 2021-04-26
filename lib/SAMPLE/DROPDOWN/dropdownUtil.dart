import 'package:flutter/material.dart';

Container dropdownMenu(List list, String defaultValue,double widthSize,double heightSize, bool isDisable, Function changeEvent){
  return Container(
    height: heightSize,
    child: DropdownButtonHideUnderline(
      child: DropdownButton(
        value: defaultValue,
        items: list.map((e) {
          return DropdownMenuItem(
            value: e['value'],
            child:  Text(
              e['text'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.black45,
              ),
            ),
          );
        }).toList(),
        onChanged: isDisable?null:changeEvent,
        //hint: Text("dis!"),
        disabledHint: Text('-'),
        //style: Theme.of(context).textTheme.title,
      ),
    ),
    width: widthSize,
    padding: EdgeInsets.only(
      left: 10,
      right: 10,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.grey[200],
      border: Border(
        top: BorderSide(
          color: Colors.grey[200],
          width: 1,
        ),
        right: BorderSide(
          color: Colors.grey[200],
          width: 1,
        ),
        bottom: BorderSide(
          color: Colors.grey[200],
          width: 1,
        ),
        left: BorderSide(
          color: Colors.grey[200],
          width: 1,
        ),
      ),
    ),
  );

}

