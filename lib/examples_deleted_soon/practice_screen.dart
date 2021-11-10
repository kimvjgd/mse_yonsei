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
  List<PostModel> _callList = [];
  List<PostModel> _privateEnterpriseList = [];
  List<PostModel> _otherList = [];

  // List<dynamic> categories = [
  //   'CALL',
  //   'OTHER',
  //   'PRIVATE_ENTERPRISE',
  //   'PROFESSOR_LAB',
  //   'PUBLIC_ENTERPRISE',
  //   'YONSEI',
  //   'YONSEI_MSE',
  //   'YOUTUBE'
  // ];

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<PostModel>>.value(
      initialData: [],
      value: postNetwokRepository.getAllPosts(),
      child: Consumer(builder:
          (BuildContext context, List<PostModel> posts, Widget? child) {
        _callList = [];
        _privateEnterpriseList = [];
        _otherList = [];
        for (int i = 0; i < posts.length; i++) {
          if (posts[i].category == 'CALL') {
            _callList.add(posts[i]);
          } else if (posts[i].category == 'PRIVATE_ENTERPRISE') {
            _privateEnterpriseList.add(posts[i]);
          } else if (posts[i].category == 'OTHER') {
            _otherList.add(posts[i]);
          }
        }
        return Scaffold(
          body: Stack(children: [
            Column(
              children: [
                _expandedCategory(_callList),
                _expandedCategory(_privateEnterpriseList),
                _expandedCategory(_otherList),
              ],
            ),

          ]),
        );
        // return Scaffold(
        //   body: Column(
        //     children: [
        //       Expanded(
        //         child: Container(
        //           child: ListView.builder(
        //             itemBuilder: (context, index) {
        //               if (posts[index].category == 'OTHER') {
        //                 return Row(
        //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                   children: [
        //                     Container(
        //                       child: Text(posts[index].name! ?? '?'),
        //                     ),
        //                     Container(
        //                       child: Text(posts[index].category!),
        //                     ),
        //                   ],
        //                 );
        //               }else {
        //                 return Container();
        //               }
        //             },
        //             itemCount: posts.length,
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // );
      }),
    );
  }

  Expanded _expandedCategory(List<PostModel> specific) {
    return Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) => ListTile(
                      title: Text(specific[index].name!),
                    ),
                    itemCount: specific.length,
                  ));
  }
}
