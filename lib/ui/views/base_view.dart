import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tunza_app/core/services/notification_service.dart';
import 'package:tunza_app/core/viewmodels/base_model.dart';
import 'package:tunza_app/locator.dart';

class BaseView<T extends BaseModel> extends StatefulWidget{
  final Widget Function(BuildContext context,T model, Widget child) builder;
  final Function(T) onModelReady;
  BaseView({this.builder,this.onModelReady});
  @override
  _BaseViewState<T> createState()=>_BaseViewState<T>();
}
class _BaseViewState<T extends BaseModel> extends State<BaseView<T>>{
  T model=locator<T>();
  StreamSubscription asns;
  @override
  void initState(){
    _configureDidReceiveLocalNotificationSubject();
    _configureSelectNotificationSubject();
    if(widget.onModelReady!=null){
      widget.onModelReady(model);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context)=>model,
      child: Consumer<T>(builder: widget.builder,),
    );
  }
  void _configureDidReceiveLocalNotificationSubject() {
    model.notificationService.didReceiveLocalNotificationSubject.stream
        .listen((ReceivedNotification receivedNotification) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null
              ? Text(receivedNotification.title)
              : null,
          content: receivedNotification.body != null
              ? Text(receivedNotification.body)
              : null,
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Ok'),
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
                await Navigator.pushNamed(context, "profile");//todo: replace this with call page
              },
            )
          ],
        ),
      );
    });
  }

  void _configureSelectNotificationSubject() {

    asns= model.notificationService.selectNotificationSubject.stream.listen((String payload) async {
      await Navigator.pushNamed(context, "profile");//todo: replace this with call page
    });
  }
  @override
  void dispose() {
//    model.notificationService.didReceiveLocalNotificationSubject.close();
//    model.notificationService.selectNotificationSubject.close();
    asns.cancel();
    super.dispose();
  }

}