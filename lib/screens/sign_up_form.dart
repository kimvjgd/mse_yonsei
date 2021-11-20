import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mse_yonsei/cosntants/app_color.dart';
import 'package:mse_yonsei/cosntants/auth_input_decor.dart';
import 'package:mse_yonsei/cosntants/common_size.dart';
import 'package:mse_yonsei/cosntants/firestore_keys.dart';
import 'package:mse_yonsei/home_page.dart';
import 'package:mse_yonsei/model/firebase_auth_state.dart';
import 'package:mse_yonsei/model/firestore/user_model.dart';
import 'package:mse_yonsei/model/user_model_state.dart';
import 'package:mse_yonsei/widgets/or_divider.dart';
import 'package:provider/provider.dart';
import 'package:mse_yonsei/cosntants/screen_size.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {

  String userKey = '';

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late UserModel _userModel;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwController = TextEditingController();
  TextEditingController _cpwController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    _cpwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<FirebaseAuthState>(context, listen: false).signOut();

    return Scaffold(
      backgroundColor: sign_color,
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(common_gap),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 25,
              ),
              Expanded(
                  child: Image.asset(
                'assets/images/yonsei_mse.png',
                width: size!.width / 1.7,
                height: size!.width / 1.7,
              )),
              SizedBox(
                height: 50,
              ),
              TextFormField(
                controller: _emailController,
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white70),
                decoration: textInputDecor('Email'),
                validator: (text) {
                  if (text!.isNotEmpty && text.contains("@")) {
                    return null;
                  } else {
                    return '정확한 이메일 주소를 입력해주세요';
                  }
                },
              ),
              SizedBox(
                height: common_xs_gap,
              ),
              TextFormField(
                controller: _pwController,
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white70),
                obscureText: true,
                decoration: textInputDecor('Password'),
                validator: (text) {
                  if (text!.isNotEmpty && text.length > 2) {
                    return null;
                  } else {
                    return '제대로 된 비밀번호 입력해주세요';
                  }
                },
              ),
              SizedBox(
                height: common_xs_gap,
              ),
              TextFormField(
                controller: _cpwController,
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white70),
                obscureText: true,
                decoration: textInputDecor('Confirm Password'),
                validator: (text) {
                  if (text!.isNotEmpty && _pwController.text == text) {
                    return null;
                  } else {
                    return '입력한 값이 비밀번호와 일치하지 않습니다.';
                  }
                },
              ),
              SizedBox(
                height: common_s_gap,
              ),
              _submitButton(context),
              SizedBox(
                height: common_s_gap,
              ),
              OrDivider(),
              FlatButton.icon(
                  onPressed: () {
                    Provider.of<FirebaseAuthState>(context, listen: false)
                        .changeFirebaseAuthStatus(FirebaseAuthStatus.signin);
                  },
                  textColor: Colors.blue,
                  icon: ImageIcon(AssetImage('assets/images/facebook.png')),
                  label: Text("Login with Facebook"))
            ],
          ),
        ),
      ),
    );
  }


  FlatButton _submitButton(BuildContext context) {
    return FlatButton(
      color: Colors.blue,
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          await Provider.of<FirebaseAuthState>(context, listen: false).registerUser(
              context,
              email: _emailController.text,
              password: _pwController.text);
          userKey =
              Provider.of<UserModelState>(context, listen: false).userModel.userKey;
          await FirebaseFirestore.instance.collection(COLLECTION_USERS).doc(userKey).collection('repo').doc('first_$userKey').set({'name':'Welcome, new friend'});

          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => MyHomePage()));
        }
      },
      child: Text(
        'Join',
        style: TextStyle(color: Colors.white),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    );
  }
}
