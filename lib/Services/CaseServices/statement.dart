class Statements{
  String statement_id;
  String statements;

  Statements({this.statement_id,this.statements});

  factory Statements.fromJson(Map<String,dynamic> json){
    return Statements(
        statement_id: json['statement_id'] as String,
        statements: json['statements'] as String
    );
  }
}