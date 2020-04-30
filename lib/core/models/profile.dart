class Profile{
  int id;
  String name;
  String email;
  String avatar_url;
  String phone_number;
  Profile.fromJson(map){
    this.name=map["name"];
    this.email=map["email"];
    this.avatar_url=map["avatar_url"];
  }

}