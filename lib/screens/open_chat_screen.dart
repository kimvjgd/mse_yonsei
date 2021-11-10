import 'package:flutter/material.dart';
import 'package:mse_yonsei/cosntants/material_color.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenChatScreen extends StatefulWidget {
  const OpenChatScreen({Key? key}) : super(key: key);

  @override
  _OpenChatScreenState createState() => _OpenChatScreenState();
}

class _OpenChatScreenState extends State<OpenChatScreen> {

  void _launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Open Chat'),backgroundColor: app_color,),
      body: Center(
        child: ListView(
          children: [
            ListTile(leading: Icon(Icons.account_tree_rounded),title: Center(child: Text('수업관련 단톡방 만들기')),onTap: (){
              _launchURL('https://open.kakao.com/o/gCK4BrJd');
            },),
            Divider(height: 1,thickness: 3,),
            ListTile(leading: Icon(Icons.volunteer_activism),title: Center(child: Text('신소재 자유 사담방')),onTap: (){
              _launchURL('https://open.kakao.com/o/gDZhQrJd');
            },),
            Divider(height: 1,thickness: 3,),
            ListTile(leading: Icon(Icons.add_comment_rounded),title: Center(child: Text('건의 및 신고')),onTap: (){
              _launchURL('https://open.kakao.com/o/gxGhMrJd');
            },),
          ],
        ),
      )
    );
  }
}


/*
수업 단톡방 만들기 https://open.kakao.com/o/gCK4BrJd
자유 사담방 https://open.kakao.com/o/gDZhQrJd
건의 및 신고 https://open.kakao.com/o/gxGhMrJd
 */
