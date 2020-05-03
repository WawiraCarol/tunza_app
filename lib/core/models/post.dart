import 'package:intl/intl.dart';

class  Post{
  int id;
  String topic;
  String created_at;
  String editor;
  int comment_count;
  Post.fromJson(map){
    this.id=map["id"];
    this.topic=map["topic"];
    this.editor=map["editor"]["name"];
    this.comment_count=map["comments_count"];
    DateTime cr=DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ").parse(map["created_at"]);
    this.created_at=DateFormat("yyyy-MM-dd HH:mm").format(cr);
  }
}