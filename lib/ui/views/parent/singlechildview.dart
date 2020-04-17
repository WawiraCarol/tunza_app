import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tunza_app/core/models/child.dart';
import 'package:tunza_app/core/viewmodels/parent/singlechildmodel.dart';
import 'package:tunza_app/ui/views/base_view.dart';

class SingleChildView extends StatelessWidget {
  Child child;
  SingleChildView(this.child);
  @override
  Widget build(BuildContext context) {
    return BaseView<SingleChildModel>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: new AppBar(title: new Text(this.child.child_name),),
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.receipt),title: Text("General")),
                BottomNavigationBarItem(icon: Icon(Icons.child_friendly),title: Text("Caregivers")),
                BottomNavigationBarItem(icon: Icon(Icons.call),title:Text("Communication")),
              ],
              currentIndex: 0,
              onTap: (i){
                switch(i){
                  case 0:
                    break;
                  case 1:
                    Navigator.pushReplacementNamed(context, "caregivers",arguments: this.child);
                    break;
                  case 2:
                    Navigator.pushReplacementNamed(context, "communication",arguments: this.child);
                    break;
                }
              },
            ),


          );
        }
    );
  }
}