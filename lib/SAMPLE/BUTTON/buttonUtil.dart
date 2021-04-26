import 'package:flutter/material.dart';

SizedBox approBottomBtn(String btnNm, double btnSize, Function onClickEvent){
  return SizedBox(
    width: btnSize,
    child: RaisedButton(
      onPressed: onClickEvent,
      child: Text(
        btnNm,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(18.0),
      ),
      color: Colors.blue,
      splashColor: Colors.blueAccent,
      //padding: EdgeInsets.all(10.0),
      padding : EdgeInsets.all(10),
    ),
  );
}

SizedBox cancelBottomBtn(String btnNm, double btnSize, Function onClickEvent){
  return SizedBox(
    width: btnSize,
    child: RaisedButton(
      onPressed: onClickEvent,
      child: Text(
        btnNm,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(18.0),
      ),
      color: Colors.red[300],
      splashColor: Colors.red,
      //padding: EdgeInsets.all(10.0),
      padding : EdgeInsets.all(10),
    ),
  );
}


SizedBox bottomDefaultBtn(String btnNm, double btnSize, Function onClickEvent){
  return  SizedBox(
    width: btnSize,
    child: RaisedButton(
      onPressed: onClickEvent,
      child: Text(
        btnNm,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(18.0),
      ),
      color: Colors.green,
      splashColor: Colors.green[300],
      //padding: EdgeInsets.all(10.0),
      padding : EdgeInsets.all(10),
    ),
  );
}

SizedBox createTopBtn(String btnNm, Function onClickEvent){
  return SizedBox(
    child: RaisedButton(
      padding: EdgeInsets.only(
        top: 0,
        right: 0,
        bottom: 0,
        left: 0,
      ),
      onPressed: onClickEvent,
      child: Text(
        btnNm,
        style: TextStyle(
            color: Colors.white,
            fontSize: 13,
        ),
      ),
      color: Colors.blueGrey[300],
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(2.0),
      ),
    ),
  );
}

TextStyle btnTextStyle(){
  return TextStyle(
    color: Colors.white,
    fontSize: 12,
  );
}