import 'package:intl/intl.dart';

class  Comment{
  int id;
  String comment;
  String created_at;
  String editor;
  Comment.fromJson(map){
    this.id=map["id"];
    this.comment=map["comment"];
    this.editor=map["editor"]["name"];
    DateTime cr=DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ").parse(map["created_at"]);
    this.created_at=DateFormat("yyyy-MM-dd HH:mm").format(cr);
  }
}