class Invite{
  int invite_id;
  String parent_name;
  String child_name;
  Invite.fromJson(map){
    this.invite_id=map["id"];
    this.child_name=map['child']['name'];
    this.parent_name=map['parent']['name'];
  }
}