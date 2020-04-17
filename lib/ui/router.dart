import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tunza_app/ui/views/caregiver/addcaretakerpage.dart';
import 'package:tunza_app/ui/views/parent/addcategoryview.dart';
import 'package:tunza_app/ui/views/parent/addchildview.dart';
import 'package:tunza_app/ui/views/parent/caregiverview.dart';
import 'package:tunza_app/ui/views/parent/categoryview.dart';
import 'package:tunza_app/ui/views/parent/communicationview.dart';
import 'package:tunza_app/ui/views/parent/home_view.dart';
import 'package:tunza_app/ui/views/parent/invitecaretakerview.dart';
import 'package:tunza_app/ui/views/auth/loginview.dart';
import 'package:tunza_app/ui/views/auth/profilepage.dart';
import 'package:tunza_app/ui/views/parent/singlechildview.dart';
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
      case "profile":
        return MaterialPageRoute(builder:(_)=>ProfilePage("My profile"));
        break;
      case "add_child":
        return MaterialPageRoute(builder: (_)=>AddChildView("Child"));
        break;
      case "child":
        return MaterialPageRoute(builder: (_)=>SingleChildView(settings.arguments));
        break;
      case "add_category":
        return MaterialPageRoute(builder: (_)=>AddCategoryView("Add Category"));
        break;
      case "categories":
        return MaterialPageRoute(builder: (_)=>CategoryView("Categories"));
        break;
      case "caregivers":
        return MaterialPageRoute(builder: (_)=>CaregiverView(settings.arguments));
        break;
      case "invite_caregiver":
        return MaterialPageRoute(builder: (_)=>InviteCaretakerView(settings.arguments));
        break;
      case "communication":
        return MaterialPageRoute(builder: (_)=>CommunicationView(settings.arguments));
        break;
    }
  }
}