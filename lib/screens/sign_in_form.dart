import 'package:flutter/material.dart';
import 'package:mse_yonsei/cosntants/app_color.dart';
import 'package:mse_yonsei/cosntants/auth_input_decor.dart';
import 'package:mse_yonsei/cosntants/common_size.dart';
import 'package:mse_yonsei/model/firebase_auth_state.dart';
import 'package:mse_yonsei/widgets/or_divider.dart';
import 'package:provider/provider.dart';
import 'package:mse_yonsei/cosntants/screen_size.dart';


class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              Image.asset('assets/images/yonsei_mse.png', width: size!.width/1.7,height: size!.width/1.7,),
              SizedBox(
                height: 50,
              ),
              TextFormField(
                controller: _emailController,
                cursorColor: Colors.black54,
                decoration: textInputDecor('Email'),
                validator: (text) {
                  if (text!.isNotEmpty && text.contains("@")) {
                    return null;
                  } else {
                    return '정확한 이메일 주소를 입력해주세용~';
                  }
                },
              ),
              SizedBox(
                height: common_xs_gap,
              ),
              TextFormField(
                controller: _pwController,
                cursorColor: Colors.black54,
                obscureText: true,
                decoration: textInputDecor('Password'),
                validator: (text) {
                  if (text!.isNotEmpty && text.length > 2) {
                    return null;
                  } else {
                    return '제대로 된 비밀번호 입력해주세용~';
                  }
                },
              ),
              FlatButton(
                onPressed: () {},
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forgotten Password?',
                    style: TextStyle(color: Colors.blue),
                  ),
                )
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
      onPressed: () {
        if (_formKey.currentState!.validate()) {

          Provider.of<FirebaseAuthState>(context, listen: false).login(context,
              email: _emailController.text, password: _pwController.text);
        }
      },
      child: Text(
        'Sign In',
        style: TextStyle(color: Colors.white),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    );
  }
}
