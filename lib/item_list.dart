import 'package:mse_yonsei/inner_list.dart';

class ItemList {

  List<InnerList> _list1 = [
    InnerList(
      name: 'MY',
      children: List.generate(6, (innerIndex) => 'myitem.1'),
    ),
    InnerList(
      name: 'other',
      children: List.generate(6, (innerIndex) => 'myitem.1'),
    ),
    InnerList(
      name: 'YONSEI MSE',
      children: List.generate(6, (innerIndex) => 'myitem.2'),
    ),
    InnerList(
      name: '공기업',
      children: List.generate(6, (innerIndex) => 'myitem.3'),
    ),
    InnerList(
      name: '사기업',
      children: List.generate(6, (innerIndex) => 'myitem.4'),
    ),
    InnerList(
      name: '랩실',
      children: List.generate(6, (innerIndex) => 'myitem.4'),
    ),
    InnerList(
        name: 'sample',
        children: ['asdf','asdf','asdf','asdf','asdf','asdf'],
    ),
  ];

  List<InnerList> get outsourceList => _list1;
}
