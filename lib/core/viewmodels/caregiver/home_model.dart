import 'package:tunza_app/core/enums/viewstate.dart';
import 'package:tunza_app/core/models/child.dart';
import 'package:tunza_app/core/models/user.dart';
import 'package:tunza_app/core/services/api.dart';
import 'package:tunza_app/core/services/authentication_service.dart';
import 'package:tunza_app/core/viewmodels/base_model.dart';
import 'package:tunza_app/locator.dart';

class CaregiverHomeModel extends BaseModel{
  AuthenticationService _authenticationService=locator<AuthenticationService>();
  User get currentUser=>_authenticationService.currentUser;
  Api _api=locator<Api>();
  List<Child> childList=[];
  //todo: display user name and email
  fetchChildren()async{
    setState(ViewState.Busy);

    childList=await _api.fetchCaregiverChildren();
    setState(ViewState.Idle);
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
}