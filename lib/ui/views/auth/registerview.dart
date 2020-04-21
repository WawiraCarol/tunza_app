import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tunza_app/core/enums/viewstate.dart';
import 'package:tunza_app/core/viewmodels/auth/login_model.dart';
import 'package:tunza_app/core/viewmodels/auth/register_model.dart';
import 'dart:convert';

import 'package:tunza_app/ui/views/base_view.dart';


class RegisterView extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => new _RegisterViewState();

}

class _RegisterViewState extends State<RegisterView> with SingleTickerProviderStateMixin{

  final formKey = new GlobalKey<FormState>();
  String _email;
  String _name;
  String _phonenumber;
  String _password;
  AnimationController _iconAnimationController;
  Animation<double> _iconAnimation;
  @override

  @override
  Widget build(BuildContext context) {
    return BaseView<RegisterModel>(
      builder: (context,model,child){
        return Scaffold(
            backgroundColor: Colors.grey,
            resizeToAvoidBottomPadding: true,

            body: model.state==ViewState.Busy?
            Center(

                child: CircularProgressIndicator()
            ):
            Stack(
              fit: StackFit.expand,
              children: <Widget>[
                new Image(
                  image: new AssetImage('assets/logo/ic_launcher.png'),
                  fit: BoxFit.cover,
                  color: Colors.black87,
                  colorBlendMode: BlendMode.darken,
                ),
                new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Form(
                        key: formKey,
                        child: Theme(
                          data: new ThemeData(
                              brightness: Brightness.dark,
                              primarySwatch: Colors.blueGrey,
                              inputDecorationTheme: new InputDecorationTheme(
                                  labelStyle: new TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 20.0
                                  )
                              )
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(40.0),
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                new TextFormField(
                                  decoration: new InputDecoration(
                                    labelText: "Enter your name",

                                  ),
                                  onSaved: (value) => _name=value,
                                  keyboardType: TextInputType.text,
                                ),
                                new TextFormField(
                                  decoration: new InputDecoration(
                                    labelText: "Enter email address",

                                  ),
                                  onSaved: (value) => _email=value,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                new TextFormField(
                                  decoration: new InputDecoration(
                                    labelText: "Enter phone number",

                                  ),
                                  onSaved: (value) => _phonenumber=value,
                                  keyboardType: TextInputType.phone,
                                ),
                                new TextFormField(
                                  decoration: new InputDecoration(
                                    labelText: "Enter password",
                                  ),
                                  keyboardType: TextInputType.text,
                                  obscureText:true,
                                  validator: (value) => value.isEmpty ? 'Password cannot be empty' : null,
                                  onSaved: (value) => _password=value,
                                ),
                                new Padding(
                                    padding: const EdgeInsets.only(top: 20.0)
                                ),
                                new MaterialButton(
                                  color: Colors.teal,
                                  textColor: Colors.white,
                                  child: new Text('Register'),
                                  onPressed:()async{
                                    if(formKey.currentState.validate()){
                                      formKey.currentState.save();
                                      var success=await model.register(_name,_email,_phonenumber, _password);
                                      if(success){
                                        model.currentuser.user_role>1?Navigator.pushReplacementNamed(context, "caregiver_home"):Navigator.pushReplacementNamed(context, "/");
                                      }
                                    }

                                  },),
                                Divider(),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: new Text("member already? click to LOGIN",style: TextStyle(fontSize: 14),),
                                )
                              ],
                            ),
                          ),
                        )

                    )
                  ],
                )
              ],

            )
        );
      },
    );

  }
}

