import 'package:get_it/get_it.dart';
import 'package:tunza_app/core/services/api.dart';
import 'package:tunza_app/core/services/authentication_service.dart';
import 'package:tunza_app/core/services/database.dart';
import 'package:tunza_app/core/services/notification_service.dart';
import 'package:tunza_app/core/services/socket_service.dart';
import 'package:tunza_app/core/viewmodels/auth/profile_model.dart';
import 'package:tunza_app/core/viewmodels/auth/register_model.dart';
import 'package:tunza_app/core/viewmodels/caregiver/home_model.dart';
import 'package:tunza_app/core/viewmodels/caregiver/invite_model.dart';
import 'package:tunza_app/core/viewmodels/communication/singlepost_model.dart';
import 'package:tunza_app/core/viewmodels/parent/addcategory_model.dart';
import 'package:tunza_app/core/viewmodels/parent/addchildinfo_model.dart';
import 'package:tunza_app/core/viewmodels/parent/caregiver_model.dart';
import 'package:tunza_app/core/viewmodels/parent/category_model.dart';
import 'package:tunza_app/core/viewmodels/parent/child_model.dart';
import 'package:tunza_app/core/viewmodels/parent/home_model.dart';
import 'package:tunza_app/core/viewmodels/parent/invitecaretakermodel.dart';
import 'package:tunza_app/core/viewmodels/auth/login_model.dart';
import 'package:tunza_app/core/viewmodels/parent/singlechildmodel.dart';
import 'package:tunza_app/core/viewmodels/communication/addpost_model.dart';
import 'package:tunza_app/core/viewmodels/communication/addcomment_model.dart';
import 'package:tunza_app/core/viewmodels/communication/communication_model.dart';


GetIt locator= GetIt.instance;
void setupLocator(){
  locator.registerLazySingleton(()=>NotificationService());
  locator.registerLazySingleton(()=>Api());
  locator.registerLazySingleton(()=>AuthenticationService());
  locator.registerLazySingleton(()=>MyDatabase());
  locator.registerLazySingleton(()=>SocketService());
  locator.registerFactory(()=>LoginModel());
  locator.registerFactory(()=>RegisterModel());
  locator.registerFactory(()=>ProfileModel());
  locator.registerFactory(()=>HomeModel());
  locator.registerFactory(()=>ChildModel());
  locator.registerFactory(()=>AddCategoryModel());
  locator.registerFactory(()=>CategoryModel());
  locator.registerFactory(()=>SingleChildModel());
  locator.registerFactory(()=>AddChildInfoModel());
  locator.registerFactory(()=>InviteCaretakerModel());
  locator.registerFactory(()=>CaregiverModel());

  locator.registerFactory(()=>CaregiverHomeModel());
  locator.registerFactory(()=>InviteModel());
  locator.registerFactory(()=>CommunicationModel());
  locator.registerFactory(()=>AddPostModel());
  locator.registerFactory(()=>SinglePostModel());
  locator.registerFactory(()=>AddCommentModel());
}