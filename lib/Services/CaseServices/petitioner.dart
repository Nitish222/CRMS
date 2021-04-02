class Petitioner{
  String petitioner_id;
  String petitioner_first_name;
  String petitioner_last_name;
  String father_name;
  String petitioner_gender;
  String petitioner_contact;
  String petitioner_address;

  Petitioner({this.petitioner_id,this.petitioner_first_name,this.petitioner_last_name, this.father_name, this.petitioner_gender, this.petitioner_contact, this.petitioner_address});

  factory Petitioner.fromJson(Map<String,dynamic> json){
    return Petitioner(
        petitioner_id: json['petitioner_id'] as String,
        petitioner_first_name: json['petitioner_first_name'] as String,
        petitioner_last_name: json['petitioner_last_name'] as String,
        petitioner_gender: json['petitioner_gender'] as String,
        petitioner_contact: json['petitioner_contact'] as String,
        petitioner_address: json['petitioner_address'] as String
    );
  }
}