import 'package:flutter/material.dart';
import 'package:tunza_app/core/enums/viewstate.dart';
import 'package:tunza_app/core/viewmodels/parent/home_model.dart';
import 'package:tunza_app/ui/views/base_view.dart';
import 'package:tunza_app/ui/views/parent/communicationview.dart';


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
              IconButton(icon: Icon(Icons.search), onPressed: (){
                showSearch(context: context, delegate: AppSearch());
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
                    child: Text("P",style: TextStyle(fontSize: 28),),

                  ),
                  otherAccountsPictures: model.currentUser.user_role==2|| model.currentUser.user_role==3? [
                    CircleAvatar(
                      child: FlatButton(
                        child: Text("C",style: TextStyle(color: Colors.white),),
                        onPressed: (){
                          Navigator.pushReplacementNamed(context, "caregiver_home");
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

              return Card(
                child: ListTile(
                  leading: Icon(Icons.child_care),
                  title: Text(model.childList[i].child_name),
                  trailing: Icon(Icons.remove_red_eye, size: 10,),
                  onLongPress: ()async{
                    await model.deleteChild(model.childList[i].child_id);
                  },
                  onTap: (){
                    Navigator.pushNamed(context, "child",arguments:model.childList[i]);
                  },
                ),
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
class AppSearch extends SearchDelegate<String>{

final cities = [
"Otse",
"Kanye",
"Lobatse",
"Ramotswa",
"Zilapo"
];
 final recentCities =[
  "Otse",
 "Kanye" 
 ];

  @override
  List<Widget> buildActions(BuildContext context) {
    //what kind of actions do i want to perform

    return [IconButton(
      icon: Icon(Icons.clear), 
      onPressed: () {
            query="";
      }
      )
    ];
  }
  

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon on the left of the app bar
    return IconButton(icon: AnimatedIcon(
      icon: AnimatedIcons.menu_arrow, 
      progress: transitionAnimation,
      ),
      onPressed: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => HomeView())
      
      ));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        child: Card(
          color: Colors.red,
          child: Center(
            child: Text(query),
          )
        ),
      )
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // give suggestions whan someone searches something
    final suggestionList = query.isEmpty ? recentCities : cities.where((p)=>p.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder:(context, index) => ListTile(
        onTap: (){
          showResults(context);
        },
        leading: Icon(Icons.location_city),
        title: RichText(
          text: TextSpan(
            text: suggestionList[index].substring(0, query.length),
            style: TextStyle(
              color: Colors.black,fontWeight: FontWeight.bold
            ),
            children: [TextSpan(
              text: suggestionList[index].substring(query.length),
              style: TextStyle(color: Colors.grey)
            )]
          )
        ),
        ),
        itemCount: suggestionList.length,
    );
  }

}