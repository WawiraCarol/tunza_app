import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tunza_app/core/enums/viewstate.dart';
import 'package:tunza_app/core/services/notification_service.dart';
import 'package:tunza_app/locator.dart';

class BaseModel extends ChangeNotifier{
  ViewState _state=ViewState.Idle;
  NotificationService notificationService=locator<NotificationService>();
  ViewState get state => _state;
  void setState(ViewState viewState){
    _state=viewState;
    notifyListeners();
  }

}