import 'package:flutter/material.dart';
import 'package:mse_yonsei/cosntants/material_color.dart';
import 'package:mse_yonsei/widgets/background.dart';

class NoticeScreen extends StatefulWidget {
  const NoticeScreen({Key? key}) : super(key: key);

  @override
  _NoticeScreenState createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notice'),backgroundColor: app_color,),
        body: Stack(
          children: [
            Background(file_name: 'homebackground'),
            Container(child: Text('어플 관련 '),),
            Center(
                child: Container(
      child: Text(
              '혹시 나중에 학생회나 학과 홈페이지에서\n어플 이용해서 공지와 알람기능을\n원한다면 사용하려고 남겨놓은 페이지입니다.',style: TextStyle(fontSize: 20,color: Colors.white),),
    )),
          ],
        ));
  }
}
