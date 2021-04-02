class Officer{
  String officerID;
  String firstName;
  String lastName;
  String officerRank;

  Officer({this.officerID,this.firstName,this.lastName,this.officerRank});

  factory Officer.fromJson(Map<String,dynamic> json){
    return Officer(
      officerID: json['officer_id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      officerRank: json['officer_rank'] as String,
    );
  }
}