class CategoryItemId{
  String category_item_id;
  String category_id;
  String item_name;

  CategoryItemId({this.category_item_id,this.category_id, this.item_name});

  factory CategoryItemId.fromJson(Map<String,dynamic> json){
    return CategoryItemId(
        category_item_id: json['category_item_id'] as String,
        category_id: json['category_id'] as String,
        item_name: json['item_name'] as String
    );
  }
}