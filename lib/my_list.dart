import 'package:expandable_tree_menu/expandable_tree_menu.dart';
import 'package:mse_yonsei/data/post_data.dart';

class MyList {
  List<TreeNode> _myList = [
    TreeNode<String>(
      'My Own Page',
      subNodes: [
        TreeNode<String>(
          'YONSEI',
          subNodes: [
            TreeNode<String>('faculty page'),
            TreeNode<String>('Professor & Lab'),
          ],
        ),
        TreeNode<String>(
          'Entertainment',
          subNodes: [
            TreeNode<String>('web-toon'),
            TreeNode<String>('shopping'),
          ],
        ),
      ],
    ),
  ];

  List<TreeNode> get myList => _myList;
}