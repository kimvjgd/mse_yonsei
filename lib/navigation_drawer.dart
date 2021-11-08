import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Expansion Tiles'),
            leading: Icon(Icons.keyboard_arrow_down),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          ListTile(
            title: Text('Drag Handle'),
            leading: Icon(Icons.drag_handle),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context)
                  .pushReplacementNamed('/drag_handle_example');
            },
          ),
        ],
      ),
    );
  }
}
