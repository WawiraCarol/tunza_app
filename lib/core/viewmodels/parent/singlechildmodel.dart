import 'package:tunza_app/core/enums/viewstate.dart';
import 'package:tunza_app/core/models/info.dart';
import 'package:tunza_app/core/services/api.dart';
import 'package:tunza_app/core/viewmodels/base_model.dart';
import 'package:tunza_app/locator.dart';

class SingleChildModel extends BaseModel{
  Api _api=locator<Api>();
  List<Info> infoList=[];
  fetchChildInfo(child_id)async{
    setState(ViewState.Busy);
    infoList=await _api.fetchChildInfo(child_id);
    setState(ViewState.Idle);
  }
  deleteChildinfo(info_id,child_id)async{
    setState(ViewState.Busy);
    var success = await _api.deleteChildInfo(info_id, child_id);
    await fetchChildInfo(child_id);
    setState(ViewState.Idle);
    return success;
  }
}