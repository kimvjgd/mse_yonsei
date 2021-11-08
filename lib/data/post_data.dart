import 'package:mse_yonsei/model/firestore/post_model.dart';

class PostData {
  List<PostModel> _postList =[
    PostModel(postKey: 'aaaa', name: 'dongdong11', url: 'www.naver.com', category: 'CALL'),
    PostModel(postKey: 'bbbb', name: 'dongdong22', url: 'www.google.com', category: 'CALL'),
    PostModel(postKey: 'cccc', name: 'dongdong33', url: 'www.daum.net', category: 'CALL'),
    PostModel(postKey: 'qqqq', name: 'yonsei', url: 'www.yonsei.ac.kr', category: 'YONSEI'),
    PostModel(postKey: 'qopq', name: 'yonsei_mse', url: 'mse.yonsei.ac.kr', category: 'YONSEI'),
    PostModel(postKey: 'alala', name: 'yonsei.qqq', url: 'www.naver.com', category: 'YONSEI'),
    PostModel(postKey: 'yuyuyuy', name: 'yonsei.dfgjn', url: 'portal.yonsei.ac.kr', category: 'YONSEI'),
  ];
 List<PostModel> get postList => _postList;
}

// final String postKey;
// final String name;
// final String phone_number;
// final String url;
// final String lab_url;
// final String professor_url;
// final String category;
// final DocumentReference reference;