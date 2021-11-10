import 'package:flutter/material.dart';
import 'package:mse_yonsei/cosntants/screen_size.dart';
import 'package:mse_yonsei/screens/expansion_body_screen.dart';
import 'package:mse_yonsei/widgets/expansion_side_menu.dart';

const duration = Duration(milliseconds: 1000);

class ExpansionScreen extends StatefulWidget {
  @override
  _ExpansionScreenState createState() => _ExpansionScreenState();
}

class _ExpansionScreenState extends State<ExpansionScreen> {
  final menuWidth = size!.width / 3*2;

  MenuStatus _menuStatus = MenuStatus.closed;
  double bodyXPos = 0;
  double menuXPos = size!.width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          AnimatedContainer(
            duration: duration,
            transform: Matrix4.translationValues(bodyXPos, 0, 0),
            curve: Curves.fastOutSlowIn,
            // body: ExpansionBodyScreen(postModelList: _postModelList),

            child: ExpansionBodyScreen(onMenuChanged: () {
              setState(() {
                _menuStatus = (_menuStatus == MenuStatus.closed)
                    ? MenuStatus.opened
                    : MenuStatus.closed;

                switch (_menuStatus) {
                  case MenuStatus.opened:
                    bodyXPos = -menuWidth;
                    menuXPos = size!.width - menuWidth;
                    break;
                  case MenuStatus.closed:
                    bodyXPos = 0;
                    menuXPos = size!.width;
                    break;
                }
              });
            }, postModelList: [],),
          ),
          AnimatedContainer(
            duration: duration,
            curve: Curves.fastOutSlowIn,
            transform: Matrix4.translationValues(menuXPos, 0, 0),
            child: ExpansionSideMenu(menuWidth: menuWidth,),
          ),
        ],
      ),
    );
  }
}

enum MenuStatus { opened, closed }
