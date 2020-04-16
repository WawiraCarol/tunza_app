import 'package:flutter/material.dart';
class ManageWorkCategory extends StatelessWidget {
  final String pageText;
  ManageWorkCategory(this.pageText);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text(pageText),),
      body: new Center(
        child: new Text(pageText),
      ),
    );
  }
}
