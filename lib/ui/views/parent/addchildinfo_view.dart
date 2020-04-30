import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tunza_app/core/models/child.dart';
import 'package:tunza_app/core/viewmodels/parent/addchildinfo_model.dart';
import 'package:tunza_app/ui/views/base_view.dart';

class AddChildInfoView extends StatelessWidget{
  Child child;
  var _formKey=GlobalKey<FormState>();
  var _topic;
  var _content;
  var _visibility = true;
  var _visibility_val = 1;
  AddChildInfoView(this.child);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BaseView<AddChildInfoModel>(
      builder: (context,model,child){
        return Scaffold(
          appBar: AppBar(
            title: Text("${this.child.child_name} - Add Info"),
          ),
          body: Container(
            padding: EdgeInsets.fromLTRB(4, 6, 4, 4),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.title),
                        labelText: 'Topic',
                        hintText: "e.g Hobbies, Likes, dislikes, abilities, allergies",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        border: OutlineInputBorder(),
                      ),
                      onSaved: (val){
                        _topic=val;
                      },
                    ),
                    Divider(),
                    TextFormField(
                      minLines: 4,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.receipt),
                        labelText: 'Content',
                        hintText: "e.g drawing, singing, cannot talk, pollen allergy e.t.c",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        border: OutlineInputBorder(),
                      ),
                      onSaved: (val){
                        _content=val;
                      },
                    ),

                    CheckboxListTile(

                      title: Text("Can be viewed by caregivers?"),

                      controlAffinity: ListTileControlAffinity.leading,
                      value: _visibility,
                      onChanged: (val){
                        _visibility=val;
                        _visibility_val=val?1:0;
                      },
                    ),
                    MaterialButton(
                      child: Text ('Save'),
                      color: Colors.blueGrey,
                      onPressed: ()async{
                        if(_formKey.currentState.validate()){
                          _formKey.currentState.save();
                          var success = await model.saveChildInfo(this.child.child_id, _topic, _content, _visibility_val);
                          if(success){
                            Navigator.of(context).pop();
                            Navigator.pushReplacementNamed(context, "child",arguments:this.child);
                          }
                        }
                      },
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