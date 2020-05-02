class Call{
  String call_url;
  int caller_id;
  String receiver_id;
  String call_type;
  Call.fromJson(map){
    this.call_url=map["call_url"];
    this.caller_id=map["caller_id"];
    this.receiver_id=map["receiver_id"];
    this.call_type=map["call_type"];

  }
}