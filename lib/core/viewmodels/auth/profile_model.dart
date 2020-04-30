import 'package:tunza_app/core/enums/viewstate.dart';
import 'package:tunza_app/core/models/profile.dart';
import 'package:tunza_app/core/models/user.dart';
import 'package:tunza_app/core/services/api.dart';
import 'package:tunza_app/core/services/authentication_service.dart';
import 'package:tunza_app/core/viewmodels/base_model.dart';
import 'package:tunza_app/locator.dart';

class ProfileModel extends BaseModel{
  Api _api=locator<Api>();
  AuthenticationService _authenticationService=locator<AuthenticationService>();
  User get currentUser=>_authenticationService.currentUser;
  Profile profile;
  getUserProfile()async{
    setState(ViewState.Busy);
    profile=await _api.getUserProfile();
    setState(ViewState.Idle);
  }
}