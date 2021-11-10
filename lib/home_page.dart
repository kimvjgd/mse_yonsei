import 'package:flutter/material.dart';
import 'package:mse_yonsei/model/firestore/post_model.dart';
import 'package:mse_yonsei/model/post_state.dart';
import 'package:mse_yonsei/screens/expansion_screen.dart';
import 'package:mse_yonsei/screens/expansion_body_screen.dart';
import 'package:mse_yonsei/cosntants/screen_size.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {

  MyHomePage({Key? key}) : super(key: key);



  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  @override
  Widget build(BuildContext context) {
    if (size == null) size = MediaQuery
        .of(context)
        .size;
    return Consumer<PostState>(
      builder: (BuildContext context, PostState? postState, Widget? child) {
        return Scaffold(
          body: ExpansionScreen(),
          // body: ExpansionBodyScreen(postModelList: _postModelList),
        );
      },
    );
  }
}

// home: Consumer<FirebaseAuthState>(builder: (BuildContext context,
//     FirebaseAuthState? firebaseAuthState, Widget? child) {
// switch (firebaseAuthState!.firebaseAuthStatus) {
// case FirebaseAuthStatus.signout:
// _clearUserModel(context);
// _currentWidget = AuthScreen();
// break;
// case FirebaseAuthStatus.signin:
// _initUserModel(firebaseAuthState, context);
// _currentWidget = HomePage();
// break;
// default:
// _currentWidget = MyProgressIndicator(containerSize: 20);
// }
// return AnimatedSwitcher(
// duration: Duration(milliseconds: 300),
// child: _currentWidget,
// );
// }),
// ),
// );
// }