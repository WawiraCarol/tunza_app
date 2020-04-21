import 'package:tunza_app/core/enums/viewstate.dart';
import 'package:tunza_app/core/models/caregiver.dart';
import 'package:tunza_app/core/models/invite.dart';
import 'package:tunza_app/core/services/api.dart';
import 'package:tunza_app/core/viewmodels/base_model.dart';
import 'package:tunza_app/locator.dart';

class InviteModel extends BaseModel{
  Api _api=locator<Api>();
  List<Invite> inviteList=[];
  fetchInvites()async{
    setState(ViewState.Busy);
    inviteList= await _api.fetchInvites();
    setState(ViewState.Idle);
  }
  updateInvite(invite_id,stat)async{
    setState(ViewState.Busy);
    var success= await _api.updateInvite(invite_id,stat);
    await fetchInvites();
    setState(ViewState.Idle);
    return success;
  }
}