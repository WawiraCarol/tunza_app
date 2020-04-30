import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tunza_app/core/enums/viewstate.dart';
import 'package:tunza_app/core/viewmodels/auth/register_model.dart';
import 'package:tunza_app/res/strings.dart';
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
  File _avatar;

  getImage()async{
    var image=await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _avatar=image;
    });
  }

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
            SingleChildScrollView(
              child:  Column(
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
                              FlatButton(
                                child:  _avatar!=null?ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.file(_avatar,height: MediaQuery.of(context).size.height*0.20,),
                                ):Image(
                                  image:NetworkImage(StringConstants.add_avatar_url),
                                  height: MediaQuery.of(context).size.height*0.20,
                                ),

                                onPressed: ()async{
                                  await getImage();
                                },
                              ),
                              new TextFormField(
                                decoration: new InputDecoration(
                                  labelText: "Enter your name",

                                ),
                                validator: (value)=>value.isEmpty ? 'Name cannot be empty':null,
                                onSaved: (value) => _name=value,
                                keyboardType: TextInputType.text,
                              ),
                              new TextFormField(
                                decoration: new InputDecoration(
                                  labelText: "Enter email address",

                                ),
                                validator: (value)=>value.isEmpty ? 'Email cannot be empty':null,
                                onSaved: (value) => _email=value,
                                keyboardType: TextInputType.emailAddress,
                              ),
                              new TextFormField(
                                decoration: new InputDecoration(
                                  labelText: "Enter phone number",

                                ),
                                  validator: (value)=>value.isEmpty ? 'Phone number cannot be empty':null,
                                onSaved: (value) => _phonenumber=value,
                                keyboardType: TextInputType.phone,
                              ),
                              new TextFormField(
                                decoration: new InputDecoration(
                                    labelText: "Enter password",
                                    hintText: "length > 8"
                                ),
                                keyboardType: TextInputType.text,
                                obscureText:true,
                                onChanged: (val){
                                  setState(() {
                                    _password=val;
                                  });
                                },
                                validator: (value) => value.isEmpty ? 'Password cannot be empty':value.length<8?'Password should be more than 8 characters' : null,
                                onSaved: (value) => _password=value,
                              ),
                              new TextFormField(
                                decoration: new InputDecoration(
                                  labelText: "Confirm password",
                                ),
                                keyboardType: TextInputType.text,
                                obscureText:true,
                                validator: (value)=>value.isEmpty ? 'Confirmation Password cannot be empty'
                                    :value!=_password?'Confirmation Password is not same as password set': null
                                ,
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
                                    var success=await model.register(_name,_email,_phonenumber, _password,avatar:_avatar);
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
                                child: new Text("member already? click to LOGIN",style: TextStyle(fontSize: 14,decoration: TextDecoration.underline),),
                              )
                            ],
                          ),
                        ),
                      )

                  )
                ],
              ),
            )
        );
      },
    );

  }
}

