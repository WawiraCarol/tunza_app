import 'package:tunza_app/core/enums/viewstate.dart';
import 'package:tunza_app/core/services/api.dart';
import 'package:tunza_app/core/viewmodels/base_model.dart';
import 'package:tunza_app/locator.dart';

class AddCategoryModel extends BaseModel{
  Api _api=locator<Api>();
  addCategory(name)async{
    setState(ViewState.Busy);
    var success= await _api.addCategory(name);
    setState(ViewState.Idle);
    return success;
  }
}