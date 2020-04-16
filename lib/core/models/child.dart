class Child{
  int child_id;
  String child_name;
  String child_date_of_birth;
  Child.fromJson(map){
    this.child_id=map['id'];
    this.child_name=map["name"];
    this.child_date_of_birth=map["date_of_birth"];
  }
}