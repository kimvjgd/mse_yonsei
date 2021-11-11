import 'package:flutter/material.dart';
import 'package:mse_yonsei/cosntants/material_color.dart';
import 'package:mse_yonsei/model/firestore/notice_model.dart';
import 'package:mse_yonsei/repo/notice_network_repository.dart';
import 'package:mse_yonsei/screens/notice_detail_screen.dart';
import 'package:mse_yonsei/widgets/background.dart';
import 'package:provider/provider.dart';

class NoticeScreen extends StatefulWidget {
  const NoticeScreen({Key? key}) : super(key: key);

  @override
  _NoticeScreenState createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<NoticeModel>>.value(
      initialData: [],
      value: noticeNetworkRepository.getAllNotice(),
      child: Consumer(builder:
          (BuildContext context, List<NoticeModel> notices, Widget? child) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Notice'),
              backgroundColor: app_color,
            ),
            body: Stack(
              children: [
                Background(file_name: 'homebackground'),
                ListView.builder(
                  itemBuilder: (context, index) => Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NoticeDetailScreen(noticeModel: notices[index],)));
                        },
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                notices[index].name!,
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                '${notices[index].postTime!.year}년 ${notices[index].postTime!.month}월 ${notices[index].postTime!.day}일',
                                style: TextStyle(color: Colors.white,fontSize: 13),
                              ),

                            ],
                          ),
                        ),
                      ),
                      Divider(
                        height: 2,
                        thickness: 1,
                        color: Colors.white,
                      )
                    ],
                  ),
                  itemCount: notices.length,)
              ],
            ));
      }),
    );
  }
}
