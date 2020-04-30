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
            backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQOL0wCKxBI3i8-S8OnckAeaszWpVHziXKSnzBRNuABcKZw66M-&usqp=CAU"),
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