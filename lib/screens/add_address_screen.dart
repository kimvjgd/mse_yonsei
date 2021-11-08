import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mse_yonsei/cosntants/auth_input_decor.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  int _height = 80;
  int _textSize = 40;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>(); //칸 form의 상태를 저장해준다.
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _urlEditingController = TextEditingController();

  @override
  void dispose() {
    _nameEditingController.dispose();
    _urlEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            'Add Button',
            style: TextStyle(fontFamily: 'DonghyunKo'),
          ),
        ),
        body: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              top: 0,
              child: FittedBox(
                child: Image.asset('assets/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _nameTextField('Write the name of page...'),
                  _urlTextField(
                      'Write the url address\nEx) https://www.@@@@@@.com'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _heightWidget(context, 60, 100),
                      _textSizeWidget(context, 30, 50),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.pink),
                    ),
                    height: _height.toDouble(),
                    child: Center(
                      child: Text(
                        _nameEditingController.text == ''
                            ? 'Sample'
                            : _nameEditingController.text,
                        style: TextStyle(fontSize: _textSize.toDouble()),
                      ),
                    ),
                  ),
                  Spacer(),
                  _addButton(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _heightWidget(BuildContext context, int min, int max) {
    return Column(
      children: [
        Text(
          'Height',
          style: TextStyle(fontSize: 40, color: Colors.white70),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(CupertinoIcons.minus),
              onPressed: () {
                setState(() {
                  if (_height > min) {
                    _height -= 1;
                  } else {
                    SnackBar snackBar = SnackBar(
                      content: Text('높이는 ${min.toString()}이상만 가능합니다.'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                });
              },
            ),
            // SlidingNumber(
            //   number: _height,
            //   style: TextStyle(
            //       fontFamily: 'DonghyunKo',
            //       fontSize: 30,
            //       fontWeight: FontWeight.bold),
            //   duration: const Duration(milliseconds: 500),
            //   curve: Curves.easeOutQuint,
            // ),
            IconButton(
              icon: Icon(CupertinoIcons.plus),
              onPressed: () {
                if (_height < max) {
                  setState(() {
                    _height += 1;
                  });
                } else {
                  SnackBar snackBar = SnackBar(
                    content: Text('높이는 ${max.toString()}이하만 가능합니다.'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  Column _textSizeWidget(BuildContext context, int min, int max) {
    return Column(
      children: [
        Text(
          'textsize',
          style: TextStyle(fontSize: 40, color: Colors.white70),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(CupertinoIcons.minus),
              onPressed: () {
                setState(() {
                  if (_textSize > min) {
                    _textSize -= 1;
                  } else {
                    SnackBar snackBar = SnackBar(
                      content: Text('글씨 크기는 ${min.toString()}이상만 가능합니다.'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                });
              },
            ),
            // SlidingNumber(
            //   number: _textSize,
            //   style: TextStyle(
            //       fontFamily: 'DonghyunKo',
            //       fontSize: 30,
            //       fontWeight: FontWeight.bold),
            //   duration: const Duration(milliseconds: 500),
            //   curve: Curves.easeOutQuint,
            // ),
            IconButton(
              icon: Icon(CupertinoIcons.plus),
              onPressed: () {
                if (_textSize < max) {
                  setState(() {
                    _textSize += 1;
                  });
                } else {
                  SnackBar snackBar = SnackBar(
                    content: Text('높이는 ${max.toString()}이하만 가능합니다.'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  Padding _nameTextField(String hint) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: TextFormField(
        onChanged: (text) {
          setState(() {});
        },
        textInputAction: TextInputAction.next,
        style: TextStyle(color: Colors.deepOrangeAccent),
        cursorColor: Colors.deepOrangeAccent,
        controller: _nameEditingController,
        decoration: textInputDecor(hint),
        validator: (text) {
          if (text!.isNotEmpty && text.length > 1) {
            return null;
          } else {
            return '2자 이상을 입력해주세요.';
          }
        },
      ),
    );
  }

  Padding _urlTextField(String hint) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: TextFormField(
        textInputAction: TextInputAction.done,
        style: TextStyle(color: Colors.white70),
        cursorColor: Colors.deepOrangeAccent,
        controller: _urlEditingController,
        decoration: textInputDecor(hint),
        validator: (text) {
          if (text!.isNotEmpty && text.contains('.')) {
            return null;
          } else {
            return '옳바른 url 주소가 아닙니다.';
          }
        },
      ),
    );
  }

  TextButton _addButton(BuildContext context) {
    String url = '';


    return TextButton(
      onPressed: () async {
        // if (_formKey.currentState!.validate()) {
        //   if(_urlEditingController.text.contains('://')) {
        //     url = _urlEditingController.text;
        //   } else {
        //     url = 'https://${_urlEditingController.text}';
        //   }
        //   Provider.of<AddressState>(context, listen: false).addAddress(Address(
        //       name: _nameEditingController.text,
        //       url: url,
        //       height: _height.toDouble(),
        //       textSize: _textSize.toDouble()));
        //   await Future.delayed(Duration(milliseconds: 300));
        //   print(url);
        //   Navigator.of(context).pop();
        // } else {
        //   print('Validation Fail!!');
        // }
      },
      child: Text(
        'Add',
        style: TextStyle(color: Colors.white, fontSize: 50),
      ),
    );
  }
}
