import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mse_yonsei/cosntants/app_color.dart';
import 'package:mse_yonsei/cosntants/material_color.dart';
import 'package:mse_yonsei/home_page.dart';
import 'package:mse_yonsei/model/app_state.dart';
import 'package:mse_yonsei/model/firebase_auth_state.dart';
import 'package:mse_yonsei/model/post_state.dart';
import 'package:mse_yonsei/model/user_model_state.dart';
import 'package:mse_yonsei/repo/user_network_repository.dart';
import 'package:mse_yonsei/screens/auth_screen.dart';
import 'package:mse_yonsei/screens/practice_screen.dart';
import 'package:mse_yonsei/widgets/my_progress_indicator.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget _currentWidget = MyHomePage();
  FirebaseAuthState _firebaseAuthState = FirebaseAuthState();
  UserModelState _userModelState = UserModelState();
  PostState _postState = PostState();

  @override
  Widget build(BuildContext context) {


    _firebaseAuthState.watchAuthChange();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PostState>.value(value: _postState),
        ChangeNotifierProvider<AppState>(create: (_)=>AppState()),
        ChangeNotifierProvider<FirebaseAuthState>.value(value: _firebaseAuthState),
        ChangeNotifierProvider<UserModelState>.value(value: _userModelState)
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: app_color,
        ),
        debugShowCheckedModeBanner: false,
        home: Consumer<FirebaseAuthState>(builder: (BuildContext context,
            FirebaseAuthState? firebaseAuthState, Widget? child) {
          // return PracticeScreen();
          switch (firebaseAuthState!.firebaseAuthStatus) {
            case FirebaseAuthStatus.signout:
              _clearUserModel(context);
              _currentWidget = AuthScreen();
              break;
            case FirebaseAuthStatus.signin:
              _initUserModel(firebaseAuthState, context);
              _currentWidget = MyHomePage();
              break;
            default:
              _currentWidget = MyProgressIndicator(containerSize: 20);
          }
          return AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: _currentWidget,
          );
        }),
      ),
    );
  }
  void _initUserModel(FirebaseAuthState firebaseAuthState, BuildContext context) {

    UserModelState userModelState = Provider.of(context, listen: false);      // 여기서 provider로 userModelState를 계속 불러와준다..

    userModelState.currentStreamSub = userNetworkRepository
        .getUserModelStream(firebaseAuthState.firebaseUser!.uid)              // getUserModelStream은 userModel을 stream으로 계속 불러온다.
        .listen((userModel) {
      userModelState.userModel = userModel;                                   // userModelState의 userModel을 getUserModelStream으로 계속 불러오는 userModel로 계속 바꿔준다.
    });
  }

  void _clearUserModel(BuildContext context) {
    UserModelState userModelState = Provider.of<UserModelState>(context, listen: false);
    userModelState.clear();
  }
}
