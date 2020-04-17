import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tunza_app/core/viewmodels/parent/addcategory_model.dart';
import 'package:tunza_app/ui/views/base_view.dart';

class AddCategoryView extends StatelessWidget{
  String title;
  String _name;
  var _formKey=GlobalKey<FormState>();
  AddCategoryView(this.title);
  @override
  Widget build(BuildContext context) {

    return BaseView<AddCategoryModel>(
      builder: (context,model,child){
        return Scaffold(
          appBar: new AppBar(title: new Text(title),),
          body: new Center(

            child: SingleChildScrollView(
              child:Form(
                key: _formKey,
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 80.0,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.teal,
                      radius: 50.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0,horizontal: 16.0),
                      child: Divider(),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0,horizontal: 16.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: 'Category name',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value){
                          _name=value;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: MaterialButton(
                        child: Text ('Save'),
                        color: Colors.blueGrey,
                        onPressed: ()async{
                          if(_formKey.currentState.validate()){
                            _formKey.currentState.save();
                            var success= await model.addCategory(_name);
                            if(success){
                              Navigator.of(context).pop();
                              Navigator.of(context).pushReplacementNamed("categories");
                            }
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),

          ),

        );
      },
    );
  }
}