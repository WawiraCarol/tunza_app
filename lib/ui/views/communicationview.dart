import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tunza_app/core/models/child.dart';

class CommunicationView extends StatelessWidget{
  Child child;
  CommunicationView(this.child);

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text(this.child.child_name),),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.receipt),title: Text("General")),
          BottomNavigationBarItem(icon: Icon(Icons.child_friendly),title: Text("Caregivers")),
          BottomNavigationBarItem(icon: Icon(Icons.call),title:Text("Communication")),
        ],
        currentIndex: 2,
        onTap: (i){
          switch(i){
            case 0:
              Navigator.pushReplacementNamed(context, "child",arguments: this.child);
              break;
            case 1:
              Navigator.pushReplacementNamed(context, "caregivers",arguments: this.child);
              break;
            case 2:
              break;
          }
        },
      ),
    );
  }
}