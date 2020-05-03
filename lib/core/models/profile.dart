class Profile{
  int id;
  String name;
  String email;
  String avatar_url;
  String phone_number;
  Profile.fromJson(map){
    this.id=map["id"];
    this.name=map["name"];
    this.email=map["email"];
    this.avatar_url=map["avatar_url"];
    this.phone_number=map["phone_number"];
  }

}