class Evidence{
  String evidence_id;
  String category_id;
  String item_description;
  String item_quantity;

  Evidence({this.evidence_id,this.category_id,this.item_description,this.item_quantity});

  factory Evidence.fromJson(Map<String,dynamic> json){
    return Evidence(
        evidence_id: json['evidence_id'] as String,
        category_id: json['category_id'] as String,
        item_description: json['item_description'] as String,
        item_quantity: json['item_quantity'] as String
    );
  }
}