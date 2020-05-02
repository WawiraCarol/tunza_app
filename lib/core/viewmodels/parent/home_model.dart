import 'package:tunza_app/core/enums/viewstate.dart';
import 'package:tunza_app/core/models/call.dart';
import 'package:tunza_app/core/models/child.dart';
import 'package:tunza_app/core/models/user.dart';
import 'package:tunza_app/core/services/api.dart';
import 'package:tunza_app/core/services/authentication_service.dart';
import 'package:tunza_app/core/services/socket_service.dart';
import 'package:tunza_app/core/viewmodels/base_model.dart';
import 'package:tunza_app/core/viewmodels/communication/call_model.dart';
import 'package:tunza_app/locator.dart';

class HomeModel extends BaseModel{
  AuthenticationService _authenticationService=locator<AuthenticationService>();
  User get currentUser=>_authenticationService.currentUser;
  SocketService socketService=locator<SocketService>();
  Api _api=locator<Api>();
  Call current_call;
  List<Child> childList=[];
  //todo: display user name and email
  fetchChildren()async{
    setState(ViewState.Busy);

    childList=await _api.fetchChildren();
    setState(ViewState.Idle);
  }
  deleteChild(id)async{
    setState(ViewState.Busy);
    var success = await _api.deleteChild(id);
    if(success) {
      childList = await _api.fetchChildren();
      setState(ViewState.Idle);
    }
  }
  logout()async{
    setState(ViewState.Busy);
    var success =await _authenticationService.logout();
    if(!success){
      setState(ViewState.Idle);
      return false;
    }
    return success;
  }
  listenForCall()async{


  }
}