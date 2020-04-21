import 'package:flutter/material.dart';
import 'package:tunza_app/core/models/child.dart';
class ChildTile extends StatelessWidget{

  Child child;
  ChildTile(this.child);

  @override
  Widget build(BuildContext context) {

    return Card(
        child: ListTile(
          leading: CircleAvatar(
            child: new Text(child.child_name[0].toUpperCase()),
            radius: 24,
          ),
          title: Text(child.child_name,style: TextStyle(fontSize: 16.0),),
          subtitle: Text("born on: ${child.child_date_of_birth}"),
          trailing: Icon(Icons.remove_red_eye,size: 10,),
          onTap: (){
            Navigator.pushNamed(context, "caregiver_child_view",arguments: this.child);
          },
      ),

    );
  }

}