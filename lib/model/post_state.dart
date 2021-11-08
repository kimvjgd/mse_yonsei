import 'package:flutter/material.dart';
import 'package:mse_yonsei/data/post_data.dart';
import 'package:mse_yonsei/model/firestore/post_model.dart';

class PostState extends ChangeNotifier {

  PostData _postData = PostData();
  List<PostModel>? _postModelList;

  void getPostData() {
    _postModelList = _postData.postList;
  }


  List<PostModel>? get postModelList => _postModelList;

}