import 'package:get_it/get_it.dart';
import 'package:tunza_app/core/services/api.dart';
import 'package:tunza_app/core/services/authentication_service.dart';
import 'package:tunza_app/core/services/database.dart';
import 'package:tunza_app/core/viewmodels/child_model.dart';
import 'package:tunza_app/core/viewmodels/home_model.dart';
import 'package:tunza_app/core/viewmodels/login_model.dart';
import 'package:tunza_app/core/viewmodels/singlechildmodel.dart';


GetIt locator= GetIt.instance;
void setupLocator(){
  locator.registerLazySingleton(()=>Api());
  locator.registerLazySingleton(()=>AuthenticationService());
  locator.registerLazySingleton(()=>MyDatabase());
  locator.registerFactory(()=>LoginModel());
  locator.registerFactory(()=>HomeModel());
  locator.registerFactory(()=>ChildModel());
  locator.registerFactory(()=>SingleChildModel());
}