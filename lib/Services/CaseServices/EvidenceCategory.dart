class EvidenceCategory{
  String category_id;
  String category_name;

  EvidenceCategory({this.category_id,this.category_name});

  factory EvidenceCategory.fromJson(Map<String,dynamic> json){
    return EvidenceCategory(
        category_id: json['category_id'] as String,
        category_name: json['category_name'] as String
    );
  }
}