import 'package:tunza_app/core/enums/viewstate.dart';
import 'package:tunza_app/core/services/api.dart';
import 'package:tunza_app/core/viewmodels/base_model.dart';
import 'package:tunza_app/locator.dart';

class AddCommentModel extends BaseModel{
  Api _api=locator<Api>();
  addComment(topic_id,child_id,topic)async{
    setState(ViewState.Busy);
    var success = await _api.addComment(topic_id,child_id, topic);
    setState(ViewState.Idle);
    return success;
  }
  editComment(comment_id,topic_id,child_id,topic)async{
    setState(ViewState.Busy);
    var success= await _api.editComment(comment_id,topic_id, child_id, topic);
    setState(ViewState.Idle);
  }
}