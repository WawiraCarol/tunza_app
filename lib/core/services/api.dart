import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tunza_app/core/models/child.dart';
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
  Future<bool> addChild(String name,String date_of_birth)async{
    AuthenticationService _authenticationService=locator<AuthenticationService>();
    var res = await client.post("$url/user/add_child",
        headers: {"Authorization":"Bearer ${_authenticationService.currentUser.user_token}"},
        body:{"name":name,"date_of_birth":date_of_birth}
        );
    if(res.statusCode==201){
      return true;
    }else{
      print(res.body);
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
  Future<bool> deleteChild(id)async{
    AuthenticationService _authenticationService=locator<AuthenticationService>();
    var res = await client.post("$url/user/child/$id/delete",
        headers: {"Authorization":"Bearer ${_authenticationService.currentUser.user_token}"}
    );
    if(res.statusCode==200){
      return true;
    }else{
      return false;
    }
  }
}