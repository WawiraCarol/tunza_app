import 'package:flutter/material.dart';
import 'package:tunza_app/core/enums/viewstate.dart';
import 'package:tunza_app/core/viewmodels/caregiver/home_model.dart';
import 'package:tunza_app/ui/views/base_view.dart';
import 'package:tunza_app/ui/views/caregiver/childlist_view.dart';


class CaregiverHomeView extends StatefulWidget{

  createState() => new _CaregiverHomeViewState();

}

class _CaregiverHomeViewState extends State<CaregiverHomeView>{
  @override
  Widget build(BuildContext context) {
    return BaseView<CaregiverHomeModel>(
      onModelReady: (model)async {
        await model.fetchChildren();
      },
      builder: (context,model,child){
        return Scaffold(

          appBar: AppBar(title: Text('TunzaApp Home'),


            actions: <Widget>[
              IconButton(icon: Icon(Icons.perm_identity), onPressed: (){
                Navigator.pushNamed(context ,"profile");
              })

            ],
          ),
          drawer: Drawer(
            child: ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text("Test"),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit:BoxFit.cover,
                          image: NetworkImage("https://www.unicef.org/jordan/sites/unicef.org.jordan/files/styles/hero_desktop/public/20181129_JOR_445.jpg?itok=759I5CEx")
                      )
                  ),
                  accountEmail: Text("test@tester.io"),
                  currentAccountPicture: CircleAvatar(
                    child: Text("C",style: TextStyle(fontSize: 28),),

                  ),
                  otherAccountsPictures: model.currentUser.user_role==1||model.currentUser.user_role==2|| model.currentUser.user_role==3? [
                    CircleAvatar(
                      child: FlatButton(
                          child: Text("P",style: TextStyle(color: Colors.white),),
                        onPressed: (){
                            Navigator.pushReplacementNamed(context, "/");
                        },
                      ),
                    )
                  ]:null,
                ),
                ListTile(
                    title: Text('Children'),
                    trailing: Icon(Icons.child_care),
                    onTap: (){
                      Navigator.of(context).pop();
                      Navigator.pushNamed(context ,"caregiver_home");
                    }
                ),

                Divider(),
                ListTile(
                  title: Text('Invites'),
                  trailing: Icon(Icons.mail_outline),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.pushNamed(context, "view_invites");
                    }
                ),
                Divider(),
                ListTile(
                    title: Text('Appointments'),
                    trailing: Icon(Icons.access_time),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.pushNamed(context, "appointments");
                    }
                ),
                Divider(),
                ListTile(
                    title: Text('Logout'),
                    trailing: Icon(Icons.lock_open),
                    onTap: ()async{
                      var success= await model.logout();
                      if (success) {
                        Navigator.of(context).pop();
                        Navigator.pushReplacementNamed(context, "login");
                      }
                    }
                ),

              ],
            ),
          ),
          body: model.state==ViewState.Busy?
          Center(
            child: CircularProgressIndicator(),
          )
          :RefreshIndicator(
            child: model.childList.length>0?ListView.builder(itemCount:model.childList.length ,itemBuilder: (context,i){

              return ChildTile(model.childList[i]);
            }):Container(
              padding: EdgeInsets.fromLTRB(4, 0, 4, 2),
              child: Column(
                children: <Widget>[
                  Text(
                    "Welcome to tunza app.",
                    style: TextStyle(
                        fontSize: 16
                    ),
                  ),
                  Text(
                    "- To view and accept the invites, click on the side menu and go to the \"invites\" menu option."+
                        "- After you accept an invite, you can return to this page to view the child's information."+
                        "- If you still can't see the child's name on the list after accepting an invite, pull down on the page to refresh."
                        +"You can click on the child's name in the list to view more information about them.",
                    style: TextStyle(
                        fontSize: 14
                    ),
                  )
                ],
              ),
            ),
            onRefresh: ()async{
              await model.fetchChildren();
            },
          ),

        );
      },
    );
  }

}