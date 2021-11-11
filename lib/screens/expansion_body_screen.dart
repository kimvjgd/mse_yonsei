import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:expandable_tree_menu/expandable_tree_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:mse_yonsei/cosntants/material_color.dart';
import 'package:mse_yonsei/cosntants/screen_size.dart';
import 'package:mse_yonsei/model/firestore/post_model.dart';
import 'package:mse_yonsei/model/user_model_state.dart';
import 'package:mse_yonsei/repo/helper/generate_post_key.dart';
import 'package:mse_yonsei/repo/post_network_repository.dart';
import 'package:mse_yonsei/widgets/background.dart';
import 'package:mse_yonsei/inner_list.dart';
import 'package:mse_yonsei/item_list.dart';
import 'package:mse_yonsei/my_list.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ExpansionBodyScreen extends StatefulWidget {

  final Function() onMenuChanged;


  // widget.postModelList 로 쓴다.
  ExpansionBodyScreen({Key? key, required this.onMenuChanged}) : super(key: key);

  @override
  _ListTileExample createState() => _ListTileExample();
}

class _ListTileExample extends State<ExpansionBodyScreen> with SingleTickerProviderStateMixin {
  String userKey = '';

  late AnimationController _iconAnimationController;


  final menuWidth = size!.width / 3*2;

  String new_trigger='n';

  double bodyXPos = 0;
  double menuXPos = size!.width;

  void _launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';




  List<InnerList> _outsourceList = ItemList().outsourceList;

  @override
  void initState() {
    _iconAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    super.initState();

  }
  @override
  void dispose() {
    _iconAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    userKey = Provider.of<UserModelState>(context, listen: false).userModel.userKey;


    return StreamProvider<List<PostModel>>.value(
      initialData: [],
      value: postNetworkRepository.getAllYoutube(),
      child: Consumer(
        builder: (BuildContext context, List<PostModel> posts, Widget? child) {
          _outsourceList = ItemList().outsourceList;
          new_trigger = 'n';
          for (int i = 0; i < posts.length; i++) {
            if (posts[i].new_trigger=='y'){
              new_trigger = 'y';
            }
            if (posts[i].category == 'YOUTUBE') {
              _outsourceList[6].children.add(posts[i]);
            }
          }

          return Scaffold(
            backgroundColor: Colors.blueGrey,
            appBar: AppBar(
              title: Text('Mse Yonsei'),
              actions: [
                IconButton(
                  icon: AnimatedIcon(
                    icon: AnimatedIcons.menu_close,
                    progress: _iconAnimationController,
                  ),
                  onPressed: () {
                    widget.onMenuChanged();
                    _iconAnimationController.status == AnimationStatus.completed
                        ? _iconAnimationController.reverse()
                        : _iconAnimationController.forward();
                  },
                )
              ],
            ),
            body: Stack(
                children:[
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    transform: Matrix4.translationValues(bodyXPos, 0, 0),
                    curve: Curves.fastOutSlowIn,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Background(file_name: 'homebackground',),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: DragAndDropLists(
                                children: List.generate(_outsourceList.length,
                                        (index) => _buildList(index)),
                                onItemReorder: _onItemReorder,
                                onListReorder: _onListReorder,
                                // listGhost is mandatory when using expansion tiles to prevent multiple widgets using the same globalkey

                                listGhost: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                                  child: Center(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 30.0, horizontal: 100.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius: BorderRadius.circular(7.0),
                                      ),
                                      child: Icon(
                                        Icons.add_box,
                                        color: Colors.pink,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ]
            ),
          );
        },
      ),
    );
  }



  _buildList(int outerIndex) {
    var innerList = _outsourceList[outerIndex];
    return DragAndDropListExpansion(
      // canDrag: outerIndex==0?false:true,     // 큰 list가 drag할 수 있는가?
      canDrag: false,
      title: Row(
        children: [
          (outerIndex == 6 && new_trigger == 'y')?Text('New ',style: TextStyle(color: Colors.red),):Text(''),
          Text(
            '${innerList.name}',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
      // leading: Icon(Icons.ac_unit, color: Colors.white,),
      // children: List.generate(widget.postModelList.length, (index) => null)
      children: List.generate(innerList.children.length,
              (index) => _buildItem(innerList.children[index])),
      listKey: ObjectKey(innerList),
    );
  }

  _buildItem(PostModel item) {
    return DragAndDropItem(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 4, top: 4, bottom: 4),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: Colors.blueGrey, width: 1)),
          // color: Colors.grey.withOpacity(0.2),
          child: InkWell(
            child: ListTile(
              title: Text(
                item.name!,
                style: TextStyle(color: Colors.white),
              ),
            ),
            onLongPress: () => showSimpleDialog(context, item),
          ),
        ),
      ),
    );
  }

  _onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      var movedItem =
      _outsourceList[oldListIndex].children.removeAt(oldItemIndex);
      _outsourceList[newListIndex].children.insert(newItemIndex, movedItem);
    });
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    setState(() {
      var movedList = _outsourceList.removeAt(oldListIndex);
      _outsourceList.insert(newListIndex, movedList);
    });
  }

  void showSimpleDialog(BuildContext context, PostModel item) => showDialog(
    context: context,
    builder: (_) => SimpleDialog(
      backgroundColor: app_color,
      title: Container(
          child: Text(
            item.name!,
            style: TextStyle(fontSize: 24, color: Colors.white70),
          )),
      children: [
        Container(
          height: 3,
          color: Colors.amber,
        ),
        SizedBox(
          height: 5,
        ),
        if (item.phone_number != null && item.phone_number != '')
          InkWell(
            child: ListTile(
              leading: Icon(
                Icons.call,
                color: Colors.white70,
              ),
              title: Text(
                'Call',
                style: TextStyle(color: Colors.white70),
              ),
            ),
            onTap: () async {
              await FlutterPhoneDirectCaller.callNumber(item.phone_number!);
              Navigator.pop(context);
            },
          ),
        if (item.url != null && item.url != '')
          InkWell(
            child: ListTile(
              leading: Icon(
                Icons.subdirectory_arrow_right_sharp,
                color: Colors.white70,
              ),
              title: Text(
                'Url',
                style: TextStyle(color: Colors.white70),
              ),
            ),
            onTap: () {
              _launchURL(item.url!);
              Navigator.pop(context);
            },
          ),
        if (item.category == 'PROFESSOR')
          Column(
            children: [
              InkWell(
                child: ListTile(
                  leading: Icon(
                    Icons.account_balance,
                    color: Colors.white70,
                  ),
                  title: Text(
                    'Lab_url',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
                onTap: () {
                  if (item.lab_url == null || item.lab_url == '') {
                    SnackBar snackBar = SnackBar(
                      backgroundColor: app_color,
                      content: Text(
                        '해당 연구실 url이 존재하지 않습니다.',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    _launchURL(item.lab_url!);
                    Navigator.pop(context);
                  }
                },
              ),
              InkWell(
                child: ListTile(
                  leading: Icon(
                    Icons.account_box_outlined,
                    color: Colors.white70,
                  ),
                  title: Text(
                    'Prof._url',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
                onTap: () {
                  if (item.professor_url == null ||
                      item.professor_url == '') {
                    SnackBar snackBar = SnackBar(
                      backgroundColor: app_color,
                      content: Text(
                        '해당 교수님 url이 존재하지 않습니다.',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    _launchURL(item.professor_url!);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        Row(
          children: [
            Spacer(),
            InkWell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(child: Icon(Icons.add_box, color: Colors.redAccent,)),
              ),
              onTap: () async {
                final String postKey = getNewPostKey(Provider.of<UserModelState>(context, listen: false).userModel);

                await PostNetwokRepository().sendData(userKey, postKey, item.name!, item.phone_number, item.url, item.lab_url, item.professor_url, item.category);
                Navigator.pop(context);
              },
            ),
            SizedBox(width: 20,),
          ],
        ),
      ],
    ),
  );
}

Future<List<TreeNode>> _dataLoad() async {
  return MyList().myList;
}
enum MenuStatus { opened, closed }
