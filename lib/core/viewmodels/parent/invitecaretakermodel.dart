import 'package:tunza_app/core/enums/viewstate.dart';
import 'package:tunza_app/core/models/category.dart';
import 'package:tunza_app/core/services/api.dart';
import 'package:tunza_app/core/viewmodels/base_model.dart';
import 'package:tunza_app/locator.dart';

class InviteCaretakerModel extends BaseModel{
  Api _api=locator<Api>();
  List category_list=[];
  fetchRawCategories()async{
    setState(ViewState.Busy);
    category_list= await _api.fetchRawCategories();
    setState(ViewState.Idle);
  }
  sendInvite(child_id,email_provided,category_id)async{
    setState(ViewState.Busy);
    var success = await _api.sendInvite(child_id,email_provided,category_id);
    setState(ViewState.Idle);
    return success;
  }
}