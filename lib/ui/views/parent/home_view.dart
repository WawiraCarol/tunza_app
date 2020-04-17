import 'package:flutter/material.dart';
import 'package:tunza_app/core/enums/viewstate.dart';
import 'package:tunza_app/core/viewmodels/parent/home_model.dart';
import 'package:tunza_app/ui/views/base_view.dart';


class HomeView extends StatefulWidget{

  createState() => new _HomeViewState();

}

class _HomeViewState extends State<HomeView>{
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(
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
                UserAccountsDrawerHeader(accountName: Text("Test"),decoration: BoxDecoration(image: DecorationImage(fit:BoxFit.cover,image: NetworkImage("https://www.unicef.org/jordan/sites/unicef.org.jordan/files/styles/hero_desktop/public/20181129_JOR_445.jpg?itok=759I5CEx"))), accountEmail: Text("test@tester.io"),currentAccountPicture: Text("P"),otherAccountsPictures: <Widget>[Text("C")],),
                ListTile(
                    title: Text('Children'),
                    trailing: Icon(Icons.child_care),
                    onTap: (){
                      Navigator.of(context).pop();
                      Navigator.pushNamed(context ,"/");
                    }
                ),

                Divider(),
                ListTile(
                  title: Text('Manage Categories'),
                  trailing: Icon(Icons.list),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.pushNamed(context, "categories");
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
            child: ListView.builder(itemCount:model.childList.length ,itemBuilder: (context,i){

              return ListTile(
                leading: Icon(Icons.child_care),
                title: Text(model.childList[i].child_name),
                onLongPress: ()async{
                  await model.deleteChild(model.childList[i].child_id);
                },
                onTap: (){
                  Navigator.pushNamed(context, "child",arguments:model.childList[i]);
                },
              );
            }),
            onRefresh: ()async{
              await model.fetchChildren();
            },
          ),
          floatingActionButton: model.state==ViewState.Idle?FloatingActionButton.extended(
            icon: Icon(Icons.child_care),
            label: Text("add"),
            tooltip: "add child",
            onPressed: (){
              Navigator.pushNamed(context, "add_child");
            },
          ):null,

        );
      },
    );
  }

}