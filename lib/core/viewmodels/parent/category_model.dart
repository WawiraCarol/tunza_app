import 'package:tunza_app/core/enums/viewstate.dart';
import 'package:tunza_app/core/models/category.dart';
import 'package:tunza_app/core/services/api.dart';
import 'package:tunza_app/core/viewmodels/base_model.dart';
import 'package:tunza_app/locator.dart';

class CategoryModel extends BaseModel{
  Api _api=locator<Api>();
  List<Category> categoryList=[];
  fetchCategories()async{
    setState(ViewState.Busy);
    categoryList=await _api.fetchCategories();
    setState(ViewState.Idle);
  }
}