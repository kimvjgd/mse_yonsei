// import 'package:flutter/material.dart';
// import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
// import 'package:mse_yonsei/model/list_data_model.dart';
//
//
//
// class MyApp1 extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return _MyAppState1();
//   }
// }
//
// class _MyAppState1 extends State<MyApp1> {
//   bool showPerformance = false;
//
//   onSettingCallback() {
//     setState(() {
//       showPerformance = !showPerformance;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     final appTitle = 'Animated Dialog Example';
//     return MaterialApp(
//       title: appTitle,
//       showPerformanceOverlay: showPerformance,
//       home: LayoutBuilder(
//         builder: (BuildContext context, BoxConstraints constraints) {
//           return MyHomePage(
//             title: appTitle,
//             onSetting: onSettingCallback,
//           );
//         },
//       ),
//     );
//   }
// }
//
// // The StatefulWidget's job is to take in some data and create a State class.
// // In this case, the Widget takes a title, and creates a _MyHomePageState.
// class MyHomePage extends StatefulWidget {
//   final String? title;
//
//   final VoidCallback? onSetting;
//
//   MyHomePage({Key? key, this.title, this.onSetting}) : super(key: key);
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// // The State class is responsible for two things: holding some data you can
// // update and building the UI using that data.
// class _MyHomePageState extends State<MyHomePage> {
//   // Whether the green box should be visible or invisible
//
//   String? selectedIndexText;
//
//   int? selectIdx;
//
//   String? singleSelectedIndexText;
//
//   int? selectIndex;
//
//   String? multiSelectedIndexesText;
//
//   List<int>? selectedIndexes;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       body: Center(
//         child: ListView(
//           padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
//           children: <Widget>[
//
//             ListTile(
//               title: Text(
//                 "List dialog ${selectedIndexText != null && selectedIndexText!.isNotEmpty ? '(index:' + selectedIndexText! + ')' : ''}",
//               ),
//               onLongPress: () async {
//                 int? index = await showAnimatedDialog<int>(
//                   context: context,
//                   barrierDismissible: true,
//                   builder: (BuildContext context) {
//                     return ClassicListDialogWidget<ListDataModel>(
//                       titleText: 'Title',
//                       dataList: List.generate(
//                         2, (index) {
//                           return ListDataModel(
//                               name: 'Name$index', value: 'Value$index');
//                         },
//                       ),
//                       onPositiveClick: () {
//                         Navigator.of(context).pop();
//                       },
//                       onNegativeClick: () {
//                         Navigator.of(context).pop();
//                       },
//                     );
//                   },
//                   animationType: DialogTransitionType.size,
//                   curve: Curves.linear,
//                 );
//                 selectIdx = index ?? selectIdx;
//                 print('selectedIndex:$selectIdx');
//                 setState(() {
//                   this.selectedIndexText = '${selectIdx ?? ''}';
//                 });
//               },
//             ),
//
//
//
//           ],
//         ),
//       ),
//     );
//   }
// }