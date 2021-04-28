import 'package:flutter/material.dart';

class containerPopSample extends StatefulWidget {

  final String title;
  final Map<String, dynamic> data;

  const containerPopSample({Key key, this.title, this.data}) : super(key: key);

  @override
  _containerPopSampleState createState() => _containerPopSampleState();
}

class _containerPopSampleState extends State<containerPopSample> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Text(
            '잘못된 요청입니다.',
            style: TextStyle(
              fontSize: 20,
              color: Colors.lightGreen,
            ),
          ),
        ),
        color: Colors.white,
      ),
    );
  }
}
