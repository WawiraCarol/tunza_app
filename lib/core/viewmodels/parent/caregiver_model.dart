import 'package:tunza_app/core/enums/viewstate.dart';
import 'package:tunza_app/core/models/caregiver.dart';
import 'package:tunza_app/core/services/api.dart';
import 'package:tunza_app/core/viewmodels/base_model.dart';
import 'package:tunza_app/locator.dart';

class CaregiverModel extends BaseModel{
  Api _api=locator<Api>();
  List<Caregiver> caregiverList=[];
  fetchCategivers(child_id)async{
    setState(ViewState.Busy);
    caregiverList= await _api.fetchCaregivers(child_id);
    setState(ViewState.Idle);
  }
  makeCall(call_url,receiver_id,call_type)async{
    setState(ViewState.Idle);
    await _api.makeCall(call_url, receiver_id, call_type);
    setState(ViewState.Idle);
  }
}