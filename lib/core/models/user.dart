class User{
  int user_local_id;
  String user_name;
  String user_token;
  int user_role;
  User.initial(){
    this.user_name="";
    this.user_token="";
  }
  User.fromJson(map){
    this.user_name=map["name"]!=null?map["name"]:"";
    this.user_token=map["token"];
    this.user_role=map["role"];
  }
  User.fromMap(map){
    this.user_name=map["user_name"]!=null?map["user_name"]:"";
    this.user_token=map["user_token"];
    this.user_role=map["user_role"];
  }
  Map toMap(){
    final Map<String,dynamic> map= new Map<String,dynamic>();
    map["user_name"]=this.user_name;
    map["user_token"]=this.user_token;
    map["user_role"]=this.user_role;
    return map;
  }
}