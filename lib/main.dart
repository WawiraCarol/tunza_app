import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tunza_app/core/models/user.dart';
import 'package:tunza_app/locator.dart';
import 'package:tunza_app/ui/router.dart';
import 'package:tunza_app/core/services/authentication_service.dart';

void main(){
  setupLocator();
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
