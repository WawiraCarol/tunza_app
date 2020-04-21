import 'dart:async';

import 'package:tunza_app/core/models/user.dart';
import 'package:tunza_app/core/services/api.dart';
import 'package:tunza_app/core/services/database.dart';
import 'package:tunza_app/locator.dart';

class AuthenticationService{
  Api _api=locator<Api>();
  MyDatabase _myDatabase=locator<MyDatabase>();
  StreamController<User> userController=StreamController<User>();
  User currentUser;
  Future<bool> login(String email, String password)async{
    User fetchedUser=await _api.loginWithEmailAndPassword(email, password);
    var hasUser = fetchedUser!=null;
    if(hasUser){
      await _myDatabase.storeLoggedUser(fetchedUser);
      this.userController.add(fetchedUser);
      this.currentUser=fetchedUser;
    }
    return hasUser;
  }
  Future<bool> register(name,String email,phonenumber, String password)async{
    User fetchedUser=await _api.registerWithEmailAndPassword(name,email,phonenumber, password);
    var hasUser = fetchedUser!=null;
    if(hasUser){
      await _myDatabase.storeLoggedUser(fetchedUser);
      this.userController.add(fetchedUser);
      this.currentUser=fetchedUser;
    }
    return hasUser;
  }
  Future<bool> isLoggedIn() async {
    User fetchedUser=await _myDatabase.getLoggedInUser();
    if(fetchedUser!=null) {
      this.userController.add(fetchedUser);
      this.currentUser=fetchedUser;
      print(fetchedUser.user_token);
    }

    return fetchedUser!=null;
  }
  Future<User> getLoggedInUser() async {
    User fetchedUser=await _myDatabase.getLoggedInUser();


    return fetchedUser;
  }
  Future<bool> logout()async{
    var hasRemovedUser=await _myDatabase.deleteLoggedUser();
    return hasRemovedUser;
  }
}