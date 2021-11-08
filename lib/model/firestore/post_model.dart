import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mse_yonsei/cosntants/firestore_keys.dart';

class PostModel {
  final String? postKey;
  final String? name;
  final String? phone_number;
  final String? url;
  final String? lab_url;
  final String? professor_url;
  final String? category;
  final DocumentReference? reference;

  PostModel.fromMap(Map<String, dynamic>? map, this.postKey,
      {required this.reference})
      : name = map![KEY_NAME],
        phone_number = map![KEY_PHONE_NUMBER],
        url = map![KEY_URL],
        lab_url = map![KEY_LAB_URL],
        professor_url = map![KEY_PROFESSOR_URL],
        category = map![KEY_CATEGORY];

  PostModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), snapshot.id,
            reference: snapshot.reference);

  static Map<String, dynamic> getMapForCreate({required String name, String? phone_number, String? url, required String category}) {
    // return type은 Map<String, dynamic>
    Map<String, dynamic> map = Map();
    map[KEY_NAME] = name;
    map[KEY_PHONE_NUMBER] = phone_number;
    map[KEY_URL] = url;
    map[KEY_LAB_URL] = '';
    map[KEY_PROFESSOR_URL] = '';
    map[KEY_CATEGORY] = category;
    return map;
  }

  PostModel({this.postKey, this.name, this.phone_number, this.url, this.lab_url, this.professor_url, this.category, this.reference});       // for make internal example...
}
