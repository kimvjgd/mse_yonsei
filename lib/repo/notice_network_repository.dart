import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mse_yonsei/cosntants/firestore_keys.dart';
import 'package:mse_yonsei/model/firestore/notice_model.dart';
import 'package:mse_yonsei/repo/helper/transformers.dart';

class NoticeNetworkRepository with Transformers {

  Stream<List<NoticeModel>> getAllNotice() {
    return FirebaseFirestore.instance
        .collection(COLLECTION_NOTICE)
        .snapshots()
        .transform(toNotice)
        .transform(latestToTop);
  }
}

NoticeNetworkRepository noticeNetworkRepository = NoticeNetworkRepository();