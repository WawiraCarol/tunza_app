import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tunza_app/core/enums/viewstate.dart';
import 'package:tunza_app/core/viewmodels/login_model.dart';
import 'dart:convert';

import 'package:tunza_app/ui/views/base_view.dart';


class LoginView extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => new _LoginViewState();

}

class _LoginViewState extends State<LoginView> with SingleTickerProviderStateMixin{

  final formKey = new GlobalKey<FormState>();
  String _email;
  String _password;
  AnimationController _iconAnimationController;
  Animation<double> _iconAnimation;
  @override

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginModel>(
      onModelReady: (model)async{
        var hasUser=await model.isLoggedIn(context);
        hasUser?Navigator.pushReplacementNamed(context, "/"):null;
        _iconAnimationController = new AnimationController(
            vsync: this,
            duration: new Duration(milliseconds: 500)
        );

        _iconAnimation = new CurvedAnimation(
            parent: _iconAnimationController,
            curve: Curves.easeOut);
        _iconAnimation.addListener(()=> this.setState((){}));
        _iconAnimationController.forward();
      },
      builder: (context,model,child){
        return Scaffold(
            backgroundColor: Colors.grey,
            resizeToAvoidBottomPadding: true,

            body: model.state==ViewState.Busy?
            Center(

                child: CircularProgressIndicator()
            ): Stack(
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
                                    labelText: "Enter email address",

                                  ),
                                  onSaved: (value) => _email=value,
                                  keyboardType: TextInputType.emailAddress,
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
                                  child: new Text('Login'),
                                  onPressed:()async{
                                    if(formKey.currentState.validate()){
                                      formKey.currentState.save();
                                      var success=await model.login(_email, _password);
                                      if(success){
                                        Navigator.pushReplacementNamed(context, "/");
                                      }
                                    }

                                  },)
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
