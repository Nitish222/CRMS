class Accused{
  String accused_id;
  String first_name;
  String last_name;
  String contact;
  String gender;
  String criminal_records;
  String accused_address;
  String statement_id;

  Accused({this.accused_id,this.first_name,this.last_name,this.contact, this.gender, this.criminal_records, this.accused_address, this.statement_id});

  factory Accused.fromJson(Map<String,dynamic> json){
    return Accused(
      accused_id: json['accused_id'] as String,
      first_name: json['first_name'] as String,
      last_name: json['last_name'] as String,
      contact: json['contact'] as String,
      gender: json['criminal_records'] as String,
      accused_address: json['accused_address'] as String,
      statement_id: json['statement_id'] as String
    );
  }
}