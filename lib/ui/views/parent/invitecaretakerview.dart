import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tunza_app/core/models/child.dart';
import 'package:tunza_app/core/viewmodels/parent/invitecaretakermodel.dart';
import 'package:tunza_app/ui/components/dropdowntextformfield.dart';
import 'package:tunza_app/ui/views/base_view.dart';

class InviteCaretakerView extends StatefulWidget{
  Child child;
  InviteCaretakerView(this.child);
  @override
  createState()=>_InviteCaretakerViewState(child);
}
class _InviteCaretakerViewState extends State<InviteCaretakerView>{
  Child child;
  _InviteCaretakerViewState(this.child);
  var _formKey=GlobalKey<FormState>();
  var _email_provided;
  var _category_id;
  @override
  Widget build(BuildContext context) {

    return BaseView<InviteCaretakerModel>(
      onModelReady: (model)async{
        await model.fetchRawCategories();
      },
      builder: (context,model,child){
        return Scaffold(
          appBar: new AppBar(title: new Text("${this.child.child_name}- Add caregiver"),),
          body: new Center(

            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
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
                          labelText: 'Email address',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (value){
                          _email_provided=value;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0,horizontal: 16.0),
                      child: DropdownTextFormField(
                        titleText: "Categories",
                        valueField: "id",
                        textField: "name",
                        value: _category_id,
                        onChanged: (val){
                          setState(() {
                            _category_id=val;
                          });
                        },
                        onSaved: (val){
                          setState(() {
                            _category_id=val;
                          });
                        },
                        dataSource: model.category_list,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: MaterialButton(
                        child: Text ('Invite'),
                        color: Colors.blueGrey,
                        onPressed: () async{
                          if(_formKey.currentState.validate()){
                            _formKey.currentState.save();
                            var success= await model.sendInvite(this.child.child_id, _email_provided, _category_id);
                            if(success){
                              Navigator.of(context).pop();
                              Navigator.pushReplacementNamed(context, "caregivers",arguments:this.child);
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