import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:expandable_tree_menu/expandable_tree_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:mse_yonsei/model/firestore/post_model.dart';
import 'package:mse_yonsei/model/post_state.dart';
import 'package:mse_yonsei/repo/user_network_repository.dart';
import 'package:mse_yonsei/screens/add_address_screen.dart';
import 'package:mse_yonsei/screens/setting_screen.dart';
import 'package:mse_yonsei/widgets/background.dart';
import 'package:mse_yonsei/expandable_tree_menu.dart';
import 'package:mse_yonsei/flutter_speed_dial_menu_button.dart';
import 'package:mse_yonsei/inner_list.dart';
import 'package:mse_yonsei/item_list.dart';
import 'package:mse_yonsei/main_menu_floating_action_button.dart';
import 'package:mse_yonsei/my_list.dart';
import 'package:provider/provider.dart';

class ExpansionTileExample extends StatefulWidget {
  final List<PostModel>? postModelList;
  // widget.postModelList 로 쓴다.
  ExpansionTileExample({Key? key, this.postModelList}) : super(key: key);

  @override
  _ListTileExample createState() => _ListTileExample();
}

class _ListTileExample extends State<ExpansionTileExample> {
  bool _isShowDial = false;
  final nodes = <TreeNode>[];

  void _addData(data) {
    setState(() {
      nodes.addAll(data);
    });
  }

  Future<List<TreeNode>> fetchData() async {
    // Load the data from somewhere;
    return await _dataLoad();
  }
  List<InnerList> outsourceList = ItemList().outsourceList;

  // late List<InnerList> _lists;

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

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text('Mse Yonsei'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SettingScreen()));
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
              Expanded(
                child: DragAndDropLists(
                  children: List.generate(
                      outsourceList.length, (index) => _buildList(index)),
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
            Navigator.of(context).push(MaterialPageRoute(builder: (_)=>AddAddressScreen()));
          },
          backgroundColor: Colors.pink,
        ),
        FloatingActionButton(
          mini: true,
          child: Icon(Icons.wifi_protected_setup),
          onPressed: () {
            _isShowDial = !_isShowDial;
            setState(() {});
            Navigator.of(context).push(MaterialPageRoute(builder: (_)=>AddAddressScreen()));
          },
          backgroundColor: Colors.orange,
        ),
        FloatingActionButton(
          mini: true,
          child: Icon(Icons.add_to_home_screen),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_)=>AddAddressScreen()));
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
    var innerList = outsourceList[outerIndex];
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

  _buildItem(String item) {
    return DragAndDropItem(
      child: ListTile(
        title: Text(
          '${item}',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  _onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      var movedItem =
          outsourceList[oldListIndex].children.removeAt(oldItemIndex);
      outsourceList[newListIndex].children.insert(newItemIndex, movedItem);
    });
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    setState(() {
      var movedList = outsourceList.removeAt(oldListIndex);
      outsourceList.insert(newListIndex, movedList);
    });
  }
}

Future<List<TreeNode>> _dataLoad() async {
  return MyList().myList;
}
