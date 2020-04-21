import 'package:tunza_app/core/enums/viewstate.dart';
import 'package:tunza_app/core/services/api.dart';
import 'package:tunza_app/core/viewmodels/base_model.dart';
import 'package:tunza_app/locator.dart';

class AddChildInfoModel extends BaseModel{
  Api _api=locator<Api>();
  saveChildInfo(child_id,topic,content,visibility)async{
    setState(ViewState.Busy);
    var success =await _api.addChildInfo(child_id, topic, content, visibility);
    setState(ViewState.Idle);
    return success;
  }
}