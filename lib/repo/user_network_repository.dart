import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mse_yonsei/cosntants/firestore_keys.dart';
import 'package:mse_yonsei/model/firestore/user_model.dart';
import 'package:mse_yonsei/repo/helper/transformers.dart';
/*
 transformer를 통해서 데이터를 우리의 양식에 맞춰서 불러오고 읽어올 수 있습니다.
 if 회원가입하면 uid, email 만을 알 수 있다.
 허자먼 firestore의 user collection에 회원을 create하되
 username, email, universityname, subcollection 등을 같이 기입해 줄 수 있다.
 나중에 각각의 계정에 정보를 추가 시킬 때 있는 document에다가 데이터만 집어넣으면 됩니다.

 하지만 아직 코드를 덜 짜서 같이 하면 될 것 같습니다. (혹은 지우고 다르게 코드를 짜도 좋아요~)
 */

class UserNetworkRepository extends Transformers {
  Future<void> attemptCreateUser({required String userKey, required String email}) async {

    final DocumentReference userRef = FirebaseFirestore.instance.collection(COLLECTION_USERS).doc(userKey);

    DocumentSnapshot snapshot = await userRef.get();
    if(!snapshot.exists) {
      return await userRef.set(UserModel.getMapForCreateUser(email));
    }
  }

  Stream<UserModel> getUserModelStream(String userKey) {
    return FirebaseFirestore.instance
        .collection(COLLECTION_USERS)
        .doc(userKey)
        // .get() 한번만 갖고오면 안된다.
        .snapshots().transform(toUser);                   // snapshot을 userModel로 바꿔준다.  stream으로 userModel을 불러온다.
  }
}

UserNetworkRepository userNetworkRepository = UserNetworkRepository();