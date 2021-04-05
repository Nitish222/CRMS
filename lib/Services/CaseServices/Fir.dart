class Fir{
  String fir_id;
  String petitioner_id;
  String victim_id;
  String date_filed;
  String time_filed;
  String incident_date;
  String incident_location;

  Fir({this.fir_id,this.petitioner_id,this.victim_id,this.date_filed, this.time_filed, this.incident_date, this.incident_location});

  factory Fir.fromJson(Map<String,dynamic> json){
    return Fir(
        fir_id: json['fir_id'] as String,
        petitioner_id: json['petitioner_id'] as String,
        victim_id: json['victim_id'] as String,
        date_filed: json['date_filed'] as String,
        time_filed: json['time_filed'] as String,
        incident_date: json['incident_date'] as String,
        incident_location: json['incident_location'] as String
    );
  }
}