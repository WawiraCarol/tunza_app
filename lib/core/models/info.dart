class Info{
  int id;
  String topic;
  String content;
  int visibility;

  Info.fromJson(map){
    this.id=map["id"];
    this.topic=map["topic"];
    this.content=map["content"];
    this.visibility=map["visibility"];
  }

}