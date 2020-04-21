import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tunza_app/core/enums/viewstate.dart';
import 'package:tunza_app/core/models/child.dart';
import 'package:tunza_app/core/viewmodels/caregiver/invite_model.dart';
import 'package:tunza_app/core/viewmodels/parent/caregiver_model.dart';
import 'package:tunza_app/ui/views/base_view.dart';

class InviteView extends StatelessWidget{
  InviteView();

  @override

  Widget build(BuildContext context) {
    return BaseView<InviteModel>(
      onModelReady: (model)async{
        await model.fetchInvites();
      },
      builder: (context,model,child){
        return Scaffold(
            appBar: new AppBar(title: new Text('Invites'),),
            body:  model.state==ViewState.Busy?
            Center(
              child: CircularProgressIndicator(),
            )
                :RefreshIndicator(
              child: model.inviteList.length>0?ListView.builder(itemCount:model.inviteList.length ,itemBuilder: (context,i){

                return ListTile(
                  leading: Icon(Icons.child_friendly),
                  title: Text(model.inviteList[i].child_name),
                  subtitle: Text(model.inviteList[i].parent_name+" has allowed you to view ${model.inviteList[i].child_name}'s information"),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                    FlatButton(child: Text("Accept",style: TextStyle(fontSize: 10),),
                    onPressed: (){
                      model.updateInvite(model.inviteList[i].invite_id, 1);
                    },
                    ),
                    FlatButton(child: Text("Decline",style: TextStyle(fontSize: 10),),
                    onPressed: (){
                      model.updateInvite(model.inviteList[i].invite_id, 0);
                    },),
                  ],),
                  onLongPress: (){
                    //todo: allow deletion of care givers
                  },
                  onTap: (){
                    //todo: View more details on caregiver
                  },
                );
              }):Center(
                child: Text("You have no pending invites"),
              ),
              onRefresh: ()async{
                await model.fetchInvites();
              },
            ),
        );
      },
    );
  }
}