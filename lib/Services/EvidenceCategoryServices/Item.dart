class Item{
  String item_id;
  String category_id;
  String item_name;

  Item({this.item_id,this.category_id,this.item_name});

  factory Item.fromJson(Map<String,dynamic> json){
    return Item(
        item_id:  json['item_id'] as String,
        category_id: json['category_id'] as String,
        item_name: json['item_name'] as String
    );
  }
}