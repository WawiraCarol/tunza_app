import 'package:flutter/cupertino.dart';
import 'package:tunza_app/core/enums/viewstate.dart';
import 'package:tunza_app/core/models/user.dart';
import 'package:tunza_app/core/services/authentication_service.dart';
import 'package:tunza_app/core/viewmodels/base_model.dart';
import 'package:tunza_app/locator.dart';

class LoginModel extends BaseModel{
  AuthenticationService _authenticationService=locator<AuthenticationService>();
  User get currentuser=>_authenticationService.currentUser;
  String errorMessage;
  bool _hasUser;
  Future<bool> login(String email,String password)async{
    setState(ViewState.Busy);
    if(email==null){
      errorMessage="Please enter your email";
      setState(ViewState.Idle);
      return false;
    }
    if(password==null){
      errorMessage="Please enter your password";
      setState(ViewState.Idle);
      return false;
    }
    var success = await _authenticationService.login(email, password);
    if(!success){
      errorMessage="There is a problem with your email and password";
      setState(ViewState.Idle);
      return false;

    }
    setState(ViewState.Idle);
    return true;
  }
  Future<bool> isLoggedIn(BuildContext context)async{
    setState(ViewState.Busy);
    var success =await _authenticationService.isLoggedIn();
    if(!success){setState(ViewState.Idle);}
    return success;

  }
}