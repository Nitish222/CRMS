class Victim{
  String victim_id;
  String first_name;
  String last_name;
  String contact;
  String gender;
  String injuries;
  String victim_address;
  String statement_id;

  Victim({this.victim_id,this.first_name,this.last_name,this.contact, this.gender, this.injuries, this.victim_address, this.statement_id});

  factory Victim.fromJson(Map<String,dynamic> json){
    return Victim(
        victim_id: json['victim_id'] as String,
        first_name: json['first_name'] as String,
        last_name: json['last_name'] as String,
        contact: json['contact'] as String,
        gender: json['gender'] as String,
        victim_address: json['victim_address'] as String,
        statement_id: json['statement_id'] as String
    );
  }
}