import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tunza_app/core/enums/viewstate.dart';
import 'package:tunza_app/core/viewmodels/auth/profile_model.dart';
import 'package:tunza_app/res/strings.dart';
import 'package:tunza_app/ui/views/base_view.dart';
class ProfilePage extends StatelessWidget {


  final String pageText;
  ProfilePage(this.pageText);
  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileModel>(
      onModelReady: (model)async{
        await model.getUserProfile();
      },
      builder: (context,model,child){
        return Scaffold(
          appBar: new AppBar(title: new Text(pageText),),
          body: model.state!=ViewState.Busy?SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  child: Image.network(model.profile.avatar_url!=null?StringConstants.url+model.profile.avatar_url:StringConstants.missing_avatar_url,
                      height: MediaQuery.of(context).size.height * 0.40,
                      headers: model.profile.avatar_url!=null?{"Authorization":"Bearer ${model.currentUser.user_token}"}:null
                  ),
                  color: Colors.blueGrey,
                  margin: EdgeInsets.fromLTRB(1, 0, 1, 0),
                  width: MediaQuery.of(context).size.width,

                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(4, 20, 4, 12),
                  child: Card(

                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Padding(
                            padding:EdgeInsets.fromLTRB(4, 2, 4, 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Contact Details"),
                                GestureDetector(
                                  child: Icon(Icons.edit),
                                  onTap: (){
                                    //todo: edit code here
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: EdgeInsets.fromLTRB(4, 2, 4, 8),
                          child: Column(

                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text("Name: "),
                                  Text(model.profile.name),
                                ],
                              ),
                              Divider(
                                color: Colors.white,
                              ),
                              Row(
                                children: <Widget>[
                                  Text("Email: "),
                                  Text(model.profile.email),
                                ],
                              ),
                              Divider(
                                color: Colors.white,
                              ),
                              Row(
                                children: <Widget>[
                                  Text("Phone number: "),
                                  Text(model.profile.phone_number!=null?model.profile.phone_number:"+46725467234"),
                                ],
                              ),


                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                Divider(),
                Container(
                  width:MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(4, 0, 4, 2),

                  child: Card(
                      child:Padding(
                          padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
                          child: GestureDetector(
                            child: Text("Add emergency contacts",style: TextStyle(color: Colors.red,decoration: TextDecoration.underline,),),
                            onTap: (){
                              //todo: add emergency contacts
                            },
                          )
                      )
                  ),
                )

              ],
            ),

          )
              :Center(
            child: CircularProgressIndicator(),
          )
        );
      },
    );
  }
}
