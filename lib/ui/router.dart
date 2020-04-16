import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tunza_app/ui/views/addchildview.dart';
import 'package:tunza_app/ui/views/caregiver.dart';
import 'package:tunza_app/ui/views/communicationview.dart';
import 'package:tunza_app/ui/views/home_view.dart';
import 'package:tunza_app/ui/views/loginview.dart';
import 'package:tunza_app/ui/views/singlechildview.dart';
const String initialRoute="login";
class Router{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case "/":
        return MaterialPageRoute(builder:(_)=>HomeView());
        break;
      case "login":
        return MaterialPageRoute(builder:(_)=>LoginView());
        break;
      case "add_child":
        return MaterialPageRoute(builder: (_)=>AddChildView("Child"));
        break;
      case "child":
        return MaterialPageRoute(builder: (_)=>SingleChildView(settings.arguments));
        break;
      case "categories":
        return MaterialPageRoute(builder: (_)=>AddChildView("Child"));
        break;
      case "caregivers":
        return MaterialPageRoute(builder: (_)=>CaregiverView(settings.arguments));
        break;
      case "communication":
        return MaterialPageRoute(builder: (_)=>CommunicationView(settings.arguments));
        break;
    }
  }
}