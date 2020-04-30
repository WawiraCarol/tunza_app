import 'package:flutter/material.dart';
import 'package:http/http.dart';
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
              IconButton(icon: Icon(Icons.search), onPressed: 
                
                () {
          showSearch(context: context, delegate: AppSearch());
          }
            

              )
              
              

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
            child: ListView.builder(itemCount:model.childList.length ,itemBuilder: (context,i){

              return ChildTile(model.childList[i]);
            }),
            onRefresh: ()async{
              await model.fetchChildren();
            },
          ),

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
      onPressed: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => CaregiverHomeView())
      
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