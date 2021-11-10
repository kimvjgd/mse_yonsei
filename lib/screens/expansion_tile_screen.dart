import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:expandable_tree_menu/expandable_tree_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:mse_yonsei/cosntants/material_color.dart';
import 'package:mse_yonsei/model/firestore/post_model.dart';
import 'package:mse_yonsei/model/user_model_state.dart';
import 'package:mse_yonsei/repo/post_network_repository.dart';
import 'package:mse_yonsei/screens/add_address_screen.dart';
import 'package:mse_yonsei/screens/detail_screen.dart';
import 'package:mse_yonsei/screens/setting_screen.dart';
import 'package:mse_yonsei/widgets/background.dart';
import 'package:mse_yonsei/flutter_speed_dial_menu_button.dart';
import 'package:mse_yonsei/inner_list.dart';
import 'package:mse_yonsei/item_list.dart';
import 'package:mse_yonsei/main_menu_floating_action_button.dart';
import 'package:mse_yonsei/my_list.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ExpansionTileExample extends StatefulWidget {
  final List<PostModel>? postModelList;

  // widget.postModelList 로 쓴다.
  ExpansionTileExample({Key? key, this.postModelList}) : super(key: key);

  @override
  _ListTileExample createState() => _ListTileExample();
}

class _ListTileExample extends State<ExpansionTileExample> {
  void _launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

  List<PostModel> _myList = [];

  bool _isShowDial = false;
  final nodes = <TreeNode>[];

  void _addData(data) {
    setState(() {
      nodes.addAll(data);
    });
  }

  Future<List<TreeNode>> fetchData() async {
    return await _dataLoad();
  }

  List<InnerList> _outsourceList = ItemList().outsourceList;

  @override
  void initState() {
    // My Page
    fetchData().then(_addData);

    // 처음에 기본 데이터를 넣어준다.
    super.initState();
    // _lists = List.generate(10, (outerIndex) {
    //   return InnerList(
    //     // 큰거
    //     name: (outerIndex + 1).toString(),
    //     children: List.generate(
    //         6, (innerIndex) => '${outerIndex + 1}.$innerIndex'), //작은거
    //   );
    // });
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<PostModel>>.value(
      initialData: [],
      value: postNetwokRepository.getAllPosts(),
      child: Consumer(
        builder: (BuildContext context, List<PostModel> posts, Widget? child) {
          _outsourceList = ItemList().outsourceList;
          for (int i = 0; i < posts.length; i++) {
            if (posts[i].userKey ==
                Provider.of<UserModelState>(context, listen: false)
                    .userModel
                    .userKey) {
              // 내 userkey와 같은 것들만 받아와준다.
              _myList.add(posts[i]);
            } else if (posts[i].userKey == null || posts[i].userKey == '') {
              if (posts[i].category == 'YOUTUBE') {
                _outsourceList[6].children.add(posts[i]);
              }
            }
          }

          return Scaffold(
            backgroundColor: Colors.blueGrey,
            appBar: AppBar(
              title: Text('Mse Yonsei'),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SettingScreen()));
                    },
                    icon: Icon(Icons.settings)),
              ],
            ),
            body: Stack(
              fit: StackFit.expand,
              children: [
                Background(file_name: 'homebackground'),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    /*
                    Opacity(
                      opacity: 0.4,
                      child: Container(
                        child: ExpandableTree(
                          nodes: nodes,
                          nodeBuilder: _nodeBuilder,
                          onSelect: (node) => _nodeSelected(context, node),
                        ),
                      ),
                    ),
                    */
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
            floatingActionButton: _getFloatingActionButton(),
          );
        },
      ),
    );
  }

  Widget _getFloatingActionButton() {
    return SpeedDialMenuButton(
      //if needed to close the menu after clicking sub-FAB
      isShowSpeedDial: _isShowDial,
      //manually open or close menu
      updateSpeedDialStatus: (isShow) {
        //return any open or close change within the widget
        this._isShowDial = isShow;
      },
      //general init
      isMainFABMini: false,
      mainMenuFloatingActionButton: MainMenuFloatingActionButton(
          backgroundColor: Colors.white24,
          mini: false,
          child: Icon(Icons.add),
          onPressed: () {},
          closeMenuChild: Icon(Icons.close),
          closeMenuForegroundColor: Colors.white,
          closeMenuBackgroundColor: Colors.red),
      floatingActionButtonWidgetChildren: <FloatingActionButton>[
        FloatingActionButton(
          mini: true,
          child: Icon(Icons.menu),
          onPressed: () {
            _isShowDial = false;
            setState(() {});
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => AddAddressScreen()));
          },
          backgroundColor: Colors.pink,
        ),
        FloatingActionButton(
          mini: true,
          child: Icon(Icons.wifi_protected_setup),
          onPressed: () {
            _isShowDial = !_isShowDial;
            setState(() {});
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => AddAddressScreen()));
          },
          backgroundColor: Colors.orange,
        ),
        FloatingActionButton(
          mini: true,
          child: Icon(Icons.add_to_home_screen),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => AddAddressScreen()));
          },
          backgroundColor: Colors.deepPurple,
        ),
      ],
      isSpeedDialFABsMini: true,
      paddingBtwSpeedDialButton: 30.0,
    );
  }

  /// Handle the onTap event on a Node Widget
  void _nodeSelected(context, nodeValue) {
    final route =
        MaterialPageRoute(builder: (context) => DetailPage(value: nodeValue));
    Navigator.of(context).push(route);
  }

  /// Build the Node widget at a specific node in the tree
  Widget _nodeBuilder(context, nodeValue) {
    return Card(
        margin: EdgeInsets.symmetric(vertical: 1),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(nodeValue.toString()),
        ));
  }

  _buildList(int outerIndex) {
    var innerList = _outsourceList[outerIndex];
    return DragAndDropListExpansion(
      // canDrag: outerIndex==0?false:true,     // 큰 list가 drag할 수 있는가?
      canDrag: true,
      title: Text(
        '${innerList.name}',
        style: TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        outerIndex == 0 ? 'reorderable' : 'fixed',
        style: TextStyle(color: Colors.white70),
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
                onTap: () {
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
          ],
        ),
      );
}

Future<List<TreeNode>> _dataLoad() async {
  return MyList().myList;
}
