import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mse_yonsei/cosntants/firestore_keys.dart';

class UserModel {
  final String? userKey;
  final String? email;
  final String? stu_num;
  final DocumentReference? reference;

  UserModel.fromMap(Map<String, dynamic>? map, this.userKey, {required this.reference})
      : email = map![KEY_EMAIL],
        stu_num = map[KEY_STU_NUMBER];

  UserModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), snapshot.id,
      reference: snapshot.reference);


  static Map<String, dynamic> getMapForCreateUser(String email) {        // return type은 Map<String, dynamic>
    Map<String, dynamic> map = Map();
    map[KEY_EMAIL] = email;
    map[KEY_STU_NUMBER] = '';
    return map;
  }
  UserModel({this.userKey, this.email, this.stu_num, this.reference});
}
