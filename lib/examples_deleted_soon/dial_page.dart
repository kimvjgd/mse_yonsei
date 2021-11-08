import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';

class DialPage extends StatefulWidget {
  const DialPage({Key? key}) : super(key: key);

  @override
  _DialPageState createState() => _DialPageState();
}

class _DialPageState extends State<DialPage> {
  TextEditingController _numberCtrl = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _numberCtrl.text = "01071164522";
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Center(
        child: ElevatedButton(
          child: Text("Test Call"),
          onPressed: () async {
            FlutterPhoneDirectCaller.callNumber(_numberCtrl.text);
          },
        )
      ),
    );
  }
}
_callNumber() async{
  const number = '08592119XXXX'; //set the number here
  bool? res = await FlutterPhoneDirectCaller.callNumber(number);
}