import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tunza_app/core/models/caregiver.dart';
import 'package:tunza_app/core/models/category.dart';
import 'package:tunza_app/core/models/child.dart';
import 'package:tunza_app/core/models/info.dart';
import 'package:tunza_app/core/models/invite.dart';
import 'dart:async';

import 'package:tunza_app/core/models/user.dart';
import 'package:tunza_app/core/services/authentication_service.dart';
import 'package:tunza_app/locator.dart';
class Api{

  static const url= "http://35.226.249.253/api";
  var client = http.Client();
  Future<User> loginWithEmailAndPassword(String email,String password)async{
    var res = await client.post("$url/login", body: {"email":email,"password":password});
    if(res.statusCode==200){
      return User.fromJson(json.decode(res.body));
    } else {
      return null;
    }
  }
  Future<User> registerWithEmailAndPassword(name,String email,phonenumber,String password)async{
    var res = await client.post("$url/register", body: {"name":name,"email":email,"phonenumber":phonenumber,"password":password});
    if(res.statusCode==200){
      return User.fromJson(json.decode(res.body));
    } else {
      return null;
    }
  }
  Future<bool> addChild(String name,String date_of_birth)async{
    AuthenticationService _authenticationService=locator<AuthenticationService>();
    var res = await client.post("$url/user/add_child",
        headers: {"Authorization":"Bearer ${_authenticationService.currentUser.user_token}"},
        body:{"name":name,"date_of_birth":date_of_birth}
        );
    if(res.statusCode==201){
      return true;
    }else{
      //print(res.body);
      return false;
    }
  }
  Future <List<Child>> fetchChildren()async{
    AuthenticationService _authenticationService=locator<AuthenticationService>();
    var res = await client.get("$url/user/children",
        headers: {"Authorization":"Bearer ${_authenticationService.currentUser.user_token}"}
    );
    if(res.statusCode==200){
      List data=json.decode(res.body);
      var children=List.generate(data.length, (i){
        return Child.fromJson(data[i]);
      });
      return children;
    }else{
      return [];
    }

  }
  Future<bool> deleteChild(child_id)async{
    AuthenticationService _authenticationService=locator<AuthenticationService>();
    var res = await client.post("$url/user/child/$child_id/delete",
        headers: {"Authorization":"Bearer ${_authenticationService.currentUser.user_token}"}
    );
    if(res.statusCode==200){
      return true;
    }else{
      return false;
    }
  }
  Future<bool> addCategory(name)async{
    AuthenticationService _authenticationService=locator<AuthenticationService>();
    var res = await client.post("$url/user/add_category",
        headers: {"Authorization":"Bearer ${_authenticationService.currentUser.user_token}"},
        body: {"name":name}
    );
    if(res.statusCode==201){
      return true;
    }else{
      print(res.body);
      return false;
    }
  }
  Future<List<Category>> fetchCategories()async{
    AuthenticationService _authenticationService=locator<AuthenticationService>();
    var res = await client.get("$url/user/categories",
        headers: {"Authorization":"Bearer ${_authenticationService.currentUser.user_token}"}
    );
    if(res.statusCode==200){
      List data=json.decode(res.body);
      if(data.length>0) {
        var categories = List.generate(data.length, (i) {
          return Category.fromJson(data[i]);
        });
        return categories;
      }else{
        return [Category.empty()];
      }
    }else{
      return [Category.empty()];
    }
  }
  Future<List> fetchRawCategories()async{
    AuthenticationService _authenticationService=locator<AuthenticationService>();
    var res = await client.get("$url/user/categories",
        headers: {"Authorization":"Bearer ${_authenticationService.currentUser.user_token}"}
    );
    if(res.statusCode==200){
      List data=json.decode(res.body);

        return data;
    }else{
      return [];
    }
  }
  //todo: fetch list of caregivers in a category and check children assigned to them
  Future<List<Caregiver>> fetchCaregivers(child_id)async{
    AuthenticationService _authenticationService=locator<AuthenticationService>();
    var res = await client.get("$url/user/child/$child_id/caregivers",
        headers: {"Authorization":"Bearer ${_authenticationService.currentUser.user_token}"}
    );
    if(res.statusCode==200){
      List data=json.decode(res.body);
      var caregivers=List.generate(data.length, (i){
        return Caregiver.fromJson(data[i]);
      });
      return caregivers;
    }else{
      return [];
    }
  }
  Future<bool> sendInvite(child_id,email_provided,int category_id)async{
    AuthenticationService _authenticationService=locator<AuthenticationService>();
    var res = await client.post("$url/user/child/$child_id/add_caregiver",
        headers: {"Authorization":"Bearer ${_authenticationService.currentUser.user_token}"},
      body: {"email_provided":email_provided,"category_id":category_id.toString()}
    );
    if(res.statusCode==201){
      return true;
    }else{
      print(res.body);
      return false;
    }
  }

  Future <List<Child>> fetchCaregiverChildren()async{
    AuthenticationService _authenticationService=locator<AuthenticationService>();
    var res = await client.get("$url/caregiver/children",
        headers: {"Authorization":"Bearer ${_authenticationService.currentUser.user_token}"}
    );
    if(res.statusCode==200){
      List data=json.decode(res.body);
      var children=List.generate(data.length, (i){
        return Child.fromJson(data[i]);
      });
      return children;
    }else{
      return [];
    }

  }
  Future<List<Invite>> fetchInvites()async{
    AuthenticationService _authenticationService=locator<AuthenticationService>();
    var res = await client.get("$url/caregiver/invites",
        headers: {"Authorization":"Bearer ${_authenticationService.currentUser.user_token}"}
    );
    if(res.statusCode==200){
      List data=json.decode(res.body);
      var invites=List.generate(data.length, (i){
        return Invite.fromJson(data[i]);
      });
      return invites;
    }else{
      return [];
    }
  }
  Future<bool> updateInvite(invite_id,stat)async{
    AuthenticationService _authenticationService=locator<AuthenticationService>();
    var res = await client.post("$url/caregiver/invite/$invite_id/update",
        headers: {"Authorization":"Bearer ${_authenticationService.currentUser.user_token}"},
        body: {"status":stat.toString()}
    );
    if(res.statusCode==200){
      return true;
    }else{
      print(res.body);
      return false;
    }
  }
  Future<bool> addChildInfo(child_id,topic,content,visibility)async{
    AuthenticationService _authenticationService=locator<AuthenticationService>();
    var res = await client.post("$url/user/child/$child_id/add_basicinfo",
        headers: {"Authorization":"Bearer ${_authenticationService.currentUser.user_token}"},
        body: {"topic":topic,"content":content,"visibility":visibility.toString()}
    );
    if(res.statusCode==200){
      return true;
    }else{
      print(res.body);
      return false;
    }
  }
  Future<List<Info>> fetchChildInfo(child_id)async{
    AuthenticationService _authenticationService=locator<AuthenticationService>();
    var res = await client.get("$url/user/child/$child_id/basicinfos",
        headers: {"Authorization":"Bearer ${_authenticationService.currentUser.user_token}"}
    );
    if(res.statusCode==200){
      List data=json.decode(res.body);
      var infos=List.generate(data.length, (i){
        return Info.fromJson(data[i]);
      });
      return infos;
    }else{
      return [];
    }
  }
}