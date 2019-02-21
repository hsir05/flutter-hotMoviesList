import 'package:flutter/material.dart';
import '../component/AttrItemContainer.dart';

class DatePicker extends StatefulWidget {
  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {

  String dateResult;
  String timeResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('日期时间插件'),
        backgroundColor: Colors.redAccent
      ),
      body: Container(
        child: Center(
          child: Column(children: <Widget>[
            MaterialButton(
              child: Text('日期',style: TextStyle(color: Colors.white),),
              color: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
               onPressed: () {
                 showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now().subtract(Duration(days: 30)), // 减 30 天
                      lastDate: DateTime.now().add(Duration(days: 30)),       // 加 30 天
                  ).then((DateTime val) {
                      print(val);   // 2018-07-12 00:00:00.000
                      setState(() {
                       dateResult = val.toString(); 
                      });
                  }).catchError((err) {
                      print(err);
                  });
               },
            ),
            AttrItemContainer(
              title: '选择日期结果:',
              editor: Text("${dateResult == null ? '请选择' : dateResult}",style: TextStyle(color: Colors.grey))
            ),
            MaterialButton(
              child: new Text('选择时间',style: TextStyle(color: Colors.white),),
              color: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              onPressed: () {
                  showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  ).then((val) {
                    print(val);
                    setState(() {
                     timeResult = val.toString(); 
                    });
                  }).catchError((err) {
                    print(err);
                  });
              },
            ),
            AttrItemContainer(
              title: '选择时间结果:',
              editor: Text("${timeResult == null ? '请选择' : timeResult}",style: TextStyle(color: Colors.grey),)
            ),
          ],),
        ),
      ));
  }
}