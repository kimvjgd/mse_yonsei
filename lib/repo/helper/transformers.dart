import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mse_yonsei/model/firestore/post_model.dart';
import 'package:mse_yonsei/model/firestore/user_model.dart';

class Transformers {
  final toUser = StreamTransformer<DocumentSnapshot, UserModel>.fromHandlers(
      //snapshot으로 들어와서 usermodel로 나간다.
      handleData: (snapshot, sink) async {
    // 받아올 데이터, 나갈 데이터
    // snapshot 받아올 data, 나기는 sink
    sink.add(UserModel.fromSnapshot(snapshot));
  });

  final toPosts =
      StreamTransformer<QuerySnapshot, List<PostModel>>.fromHandlers(
          handleData: (snapshot, sink) async {
    List<PostModel> posts = [];

    snapshot.docs.forEach((documentSnapshots) {
      posts.add(PostModel.fromSnapshot(documentSnapshots));
    });
    sink.add(posts);
  });
}
