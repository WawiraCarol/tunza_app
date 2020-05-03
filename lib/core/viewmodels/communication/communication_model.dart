import 'package:tunza_app/core/enums/viewstate.dart';
import 'package:tunza_app/core/services/api.dart';
import 'package:tunza_app/core/viewmodels/base_model.dart';
import 'package:tunza_app/core/models/post.dart';
import 'package:tunza_app/locator.dart';

class CommunicationModel extends BaseModel{
  Api _api=locator<Api>();
  List<Post> postList=[];
  fetchPosts(child_id)async{
    setState(ViewState.Busy);
    postList=await _api.fetchPosts(child_id);
    setState(ViewState.Idle);
  }
}