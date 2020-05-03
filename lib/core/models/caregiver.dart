import 'package:intl/intl.dart';

class Caregiver{
  //todo: for those who have registered fetch their names
  //todo: allow for photo uploads to server
  int caregiver_id;
  int caregiver_user_id;
  String email_provided;
  DateTime created_at;
  bool status;
  Caregiver.fromJson(map){
    this.caregiver_id=map["id"];
    this.email_provided=map["email_provided"];
    this.caregiver_user_id=map["user_id"];
    this.created_at=map["created_at"]!=null?DateFormat("yyyy-MM-dd").parse(map["created_at"]):DateFormat("yyyy-MM-dd").parse("0001-01-01");
    this.status=map["status"]!=null?(map["status"]==1?true:false):false;
  }
}