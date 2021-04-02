class Case{
  String caseID;
  String case_status;
  String case_description;
  String statement_id;
  String evidence_id;
  String fir_id;
  String officer_id;

  Case({this.caseID,this.case_status,this.case_description,this.statement_id,this.evidence_id,this.fir_id,this.officer_id});

  factory Case.fromJson(Map<String,dynamic> json){
    return Case(
      caseID: json['case_id'] as String,
      case_status: json['case_status'] as String,
      case_description: json['case_description'] as String,
      statement_id: json['statement_id'] as String,
      evidence_id: json['evidence_id'] as String,
      fir_id: json['fir_id'] as String,
      officer_id: json['officer_id'] as String,
    );
  }
}