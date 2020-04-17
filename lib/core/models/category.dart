class Category{
  String category_name;
  int category_id;
  Category.empty(){
    this.category_id=0;
    this.category_name="No categories added";
  }
  Category.fromJson(map){
    this.category_id=map["id"];
    this.category_name=map["name"];
  }
}