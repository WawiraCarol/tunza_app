import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tunza_app/core/enums/viewstate.dart';
import 'package:tunza_app/core/models/child.dart';
import 'package:tunza_app/core/viewmodels/parent/caregiver_model.dart';
import 'package:tunza_app/ui/views/base_view.dart';

class CaregiverView extends StatelessWidget{
  Child child;
  CaregiverView(this.child);

  @override

  Widget build(BuildContext context) {
    return BaseView<CaregiverModel>(
      onModelReady: (model)async{
        await model.fetchCategivers(this.child.child_id);
      },
      builder: (context,model,child){
        return Scaffold(
            appBar: new AppBar(title: new Text(this.child.child_name),),
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.receipt),title: Text("General")),
                BottomNavigationBarItem(icon: Icon(Icons.child_friendly),title: Text("Caregivers")),
                BottomNavigationBarItem(icon: Icon(Icons.call),title:Text("Communication")),
              ],
              currentIndex: 1,
              onTap: (i){
                switch(i){
                  case 0:
                    Navigator.pushReplacementNamed(context, "child",arguments: this.child);
                    break;
                  case 1:
                    break;
                  case 2:
                    Navigator.pushReplacementNamed(context, "communication",arguments: this.child);
                    break;
                }
              },
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.group_add),
              onPressed: (){
                Navigator.pushNamed(context, "invite_caregiver",arguments: this.child);
              },
            ),
            body:  model.state==ViewState.Busy?
            Center(
              child: CircularProgressIndicator(),
            )
                :RefreshIndicator(
              child: ListView.builder(itemCount:model.caregiverList.length ,itemBuilder: (context,i){

                return ListTile(
                  leading: Icon(Icons.child_friendly),
                  title: Text(model.caregiverList[i].email_provided),
                  subtitle: Text(model.caregiverList[i].status?"invite accepted":"invite pending"),
                  onLongPress: (){
                    //todo: allow deletion of care givers
                  },
                  onTap: (){
                    //todo: View more details on caregiver
                  },
                );
              }),
              onRefresh: ()async{
                await model.fetchCategivers(this.child.child_id);
              },
            ),
        );
      },
    );
  }
}