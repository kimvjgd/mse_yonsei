import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mse_yonsei/cosntants/firestore_keys.dart';
import 'package:mse_yonsei/cosntants/screen_size.dart';
import 'package:mse_yonsei/model/user_model_state.dart';
import 'package:mse_yonsei/screens/expansion_screen.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {

  MyHomePage({Key? key}) : super(key: key);



  @override
  _MyHomePageState createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {
  String userKey = '';


  @override
  Widget build(BuildContext context) {

    repoConfirm();

    if (size == null) size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      body: ExpansionScreen(),
    );
  }


  void repoConfirm() async{
    userKey =
        Provider.of<UserModelState>(context, listen: false).userModel.userKey;

    final snapshot = await FirebaseFirestore.instance.collection(COLLECTION_USERS).doc(userKey).collection('repo').get();
    if(snapshot.docs.length == 0){
      await FirebaseFirestore.instance.collection(COLLECTION_USERS).doc(userKey).collection('repo').doc('first_$userKey').set({'name':'Welcome, new friend'});
    }
  }
}