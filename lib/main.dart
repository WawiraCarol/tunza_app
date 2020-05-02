import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tunza_app/core/models/user.dart';
import 'package:tunza_app/core/services/notification_service.dart';
import 'package:tunza_app/locator.dart';
import 'package:tunza_app/ui/router.dart';
import 'package:tunza_app/core/services/authentication_service.dart';




void main()async{
  setupLocator();
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService notificationService=locator<NotificationService>();
  await notificationService.flutterLocalNotificationsPlugin.initialize(notificationService.initializationSettings,
      onSelectNotification: (String payload) async {
        if (payload != null) {
          debugPrint('notification payload: ' + payload);
        }
        notificationService.selectNotificationSubject.add(payload);
      });

  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return StreamProvider<User>.controller(
      initialData: User.initial(),
        create: (context)=>locator<AuthenticationService>().userController,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TunzaApp',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        initialRoute: "login",
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }

}
