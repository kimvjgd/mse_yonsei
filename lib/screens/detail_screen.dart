import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final value;

  const DetailPage({Key? key, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(value.toString()),
      ),
      body: Center(
        child: Text(value.toString()),
      ),
    );
  }
}
