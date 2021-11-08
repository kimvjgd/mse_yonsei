import 'package:flutter/material.dart';
import 'package:mse_yonsei/model/firestore/post_model.dart';
import 'package:mse_yonsei/repo/post_network_repository.dart';
import 'package:provider/provider.dart';

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({Key? key}) : super(key: key);

  @override
  _PracticeScreenState createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {

  List<dynamic> categories = ['CALL', 'OTHER', 'PRIVATE_ENTERPRISE', 'PROFESSOR_LAB', 'PUBLIC_ENTERPRISE', 'YONSEI', 'YONSEI_MSE', 'YOUTUBE'];
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<PostModel>>.value(
      initialData: [],
      value: postNetwokRepository.getAllPosts(),
      child: Consumer(builder:
          (BuildContext context, List<PostModel> posts, Widget? child) {
        return Scaffold(
          // body: Container(),
          body: ListView.builder(
            itemBuilder: (context, index) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(posts[index].name!??'?'),
                ),
                Container(
                  child: Text(posts[index].category!),
                ),
              ],
            ),
            itemCount: posts.length,
          ),
        );
      }),
    );
  }
}
