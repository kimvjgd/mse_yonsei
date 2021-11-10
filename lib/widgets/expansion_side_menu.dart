import 'package:flutter/material.dart';

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
            ListTile(title: Text('Setting', style: TextStyle(fontWeight: FontWeight.bold),)),
            ListTile(leading: Icon(Icons.exit_to_app, color: Colors.black87,),title: Text('Sign out'),onTap: () {
            },)
          ],
        ),
      ),
    );
  }
}
