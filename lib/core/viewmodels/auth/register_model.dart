import 'package:flutter/cupertino.dart';
import 'package:tunza_app/core/enums/viewstate.dart';
import 'package:tunza_app/core/models/user.dart';
import 'package:tunza_app/core/services/authentication_service.dart';
import 'package:tunza_app/core/services/socket_service.dart';
import 'package:tunza_app/core/viewmodels/base_model.dart';
import 'package:tunza_app/locator.dart';

class RegisterModel extends BaseModel{
  AuthenticationService _authenticationService=locator<AuthenticationService>();
  SocketService _socketService=locator<SocketService>();
  User get currentuser=>_authenticationService.currentUser;
  String errorMessage;

  Future<bool> register(name,String email,phonenumber,String password,{avatar=null})async{
    setState(ViewState.Busy);
    if(name==null){
      errorMessage="Please enter your name";
      setState(ViewState.Idle);
      return false;
    }
    if(email==null){
      errorMessage="Please enter your email";
      setState(ViewState.Idle);
      return false;
    }
    if(phonenumber==null){
      errorMessage="Please enter your phone number";
      setState(ViewState.Idle);
      return false;
    }
    if(password==null){
      errorMessage="Please enter your password";
      setState(ViewState.Idle);
      return false;
    }
    var success = await _authenticationService.register(name,email,phonenumber, password,avatar:avatar);
    if(!success){
      errorMessage="There is a problem with your email and password";
      setState(ViewState.Idle);
      return false;

    }
    setState(ViewState.Idle);
    return true;
  }
  listenForCall()async{
    setState(ViewState.Busy);
    await _socketService.disconnectFromPusher();
    await _socketService.initPusher();
    await _socketService.connectToPusher();
    await _socketService.subscribeToUserChannel();
    await _socketService.bindCallMade();
    setState(ViewState.Idle);
  }
}