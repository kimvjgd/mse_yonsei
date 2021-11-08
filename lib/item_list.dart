import 'package:mse_yonsei/inner_list.dart';

class ItemList {

  List<InnerList> _list = [
    InnerList(
      name: 'Yonsei',
      children: [],
    ),
    InnerList(
      name: 'Yonsei MSE',
      children: [],
    ),
    InnerList(
      name: 'Professor',
      children: [],
    ),
    InnerList(
      name: 'Lab',
      children: [],
    ),
    InnerList(
      name: 'Private_enterprise',
      children: [],
    ),
    InnerList(
      name: 'Gov_fund Inst.',
      children: [],
    ),
    InnerList(
      name: 'Call',
      children: [],
    ),
    InnerList(
      name: 'Youtube',
      children: [],
    ),
    InnerList(
      name: 'Other',
      children: [],
    ),
  ];

  List<InnerList> get outsourceList => _list;
  set setList(List<InnerList> newList) => _list = newList;
}
