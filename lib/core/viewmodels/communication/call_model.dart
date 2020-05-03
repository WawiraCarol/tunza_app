import 'package:tunza_app/core/enums/viewstate.dart';
import 'package:tunza_app/core/services/api.dart';
import 'package:tunza_app/core/services/socket_service.dart';
import 'package:tunza_app/core/viewmodels/base_model.dart';
import 'package:tunza_app/locator.dart';

class CallModel extends BaseModel{
  Api _api=locator<Api>();
  SocketService _socketService=locator<SocketService>();
  waitingForCall()async{
    setState(ViewState.Busy);
    await _socketService.subscribeToUserChannel();
    setState(ViewState.Idle);
  }
}