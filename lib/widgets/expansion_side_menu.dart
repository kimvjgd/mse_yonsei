import 'package:flutter/material.dart';
import 'package:mse_yonsei/screens/notice_screen.dart';
import 'package:mse_yonsei/screens/open_chat_screen.dart';
import 'package:mse_yonsei/screens/setting_screen.dart';

class ExpansionSideMenu extends StatelessWidget {

  final double menuWidth;

  const ExpansionSideMenu({Key? key, required this.menuWidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: menuWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(title: Text('MSE Yonsei', style: TextStyle(fontWeight: FontWeight.bold),)),

            ListTile(leading: Icon(Icons.account_tree, color: Colors.black87,),title: Text('Open Chat',style: TextStyle(fontSize: 17),),onTap: () {
              Navigator.push(context,MaterialPageRoute(builder: (context)=>OpenChatScreen()));
            },),
            ListTile(leading: Icon(Icons.assignment, color: Colors.black87,),title: Text('Notice',style: TextStyle(fontSize: 17),),onTap: () {
              Navigator.push(context,MaterialPageRoute(builder: (context)=>NoticeScreen()));
            },),
            ListTile(leading: Icon(Icons.settings, color: Colors.black87,),title: Text('Setting',style: TextStyle(fontSize: 17),),onTap: () {
              Navigator.push(context,MaterialPageRoute(builder: (context)=>SettingScreen()));
            },),
          ],
        ),
      ),
    );
  }
}
