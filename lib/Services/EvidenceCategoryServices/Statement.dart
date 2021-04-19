class Statement{
  String statement_id;
  String statement;

  Statement({this.statement_id,this.statement});

  factory Statement.fromJson(Map<String,dynamic> json){
    return Statement(
        statement_id:  json['statement_id'] as String,
        statement: json['statements'] as String,
    );
  }
}