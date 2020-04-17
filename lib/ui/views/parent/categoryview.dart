import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tunza_app/core/enums/viewstate.dart';
import 'package:tunza_app/core/viewmodels/parent/category_model.dart';
import 'package:tunza_app/ui/views/base_view.dart';

class CategoryView extends StatelessWidget{
  String title;
  CategoryView(this.title);
  @override
  Widget build(BuildContext context) {
    return BaseView<CategoryModel>(
      onModelReady: (model)async{
        await model.fetchCategories();
      },
      builder: (context,model,child){
        return Scaffold(
          appBar: new AppBar(title: new Text("$title"),),
          body: model.state==ViewState.Busy?
          Center(
            child: CircularProgressIndicator(),
          )
              :RefreshIndicator(
            child: ListView.builder(itemCount:model.categoryList.length ,itemBuilder: (context,i){

              return ListTile(
                leading: Icon(Icons.list),
                title: Text(model.categoryList[i].category_name),
                onLongPress: ()async{
                  //todo: delete categories
                },
                onTap: (){
                  //todo: view caretakers in a given category
                },
              );
            }),
            onRefresh: ()async{
              await model.fetchCategories();
            },
          ),
          floatingActionButton: model.state==ViewState.Idle?FloatingActionButton.extended(
            icon: Icon(Icons.list),
            label: Text("add"),
            tooltip: "add child",
            onPressed: (){
              Navigator.pushNamed(context, "add_category");
            },
          ):null,
        );
      },
    );
  }
}