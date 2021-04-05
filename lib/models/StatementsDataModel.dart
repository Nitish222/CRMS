import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Services/Actors/StatementsAPI.dart';
import 'package:myapp/Services/EvidenceCategoryServices/Statement.dart';

class StatementsDataModel extends StatefulWidget{
  StatementsDataModel():super();
  final String title = 'Add Statements';
  @override
  _DataModel_State createState()=>_DataModel_State();
}


class _DataModel_State extends State<StatementsDataModel>{
  List<Statement> _statement;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isUpdating;
  String _titleProgress;
  @override
  void initState(){
    super.initState();
    //for users
    _statement = [];
    _titleProgress = widget.title;
  }
  _getAllStatements(){
    _showProgress('Loading Statements...');
    StatementAPI.getStatement().then((statements){
      setState(() {
        _statement = statements;
      });
      _showProgress(widget.title);
      print("Length ${statements.length}");
    });
  }
  _showProgress(String message){
    setState(() {
      _titleProgress = message;
    });
  }

  SingleChildScrollView _dataBody(){
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
          child: DataTable(
            columns:[
              DataColumn(label: Text('statement_id')),
              DataColumn(label: Text('statements')),
            ],
            rows: _statement.map((statement)=> DataRow(
                cells: [
                  DataCell(Text(statement.statement_id)),
                  DataCell(
                      Container(
                        width: 300.0,
                        height: 200.0,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(statement.statement.toLowerCase()),
                        ),
                      ),),

                ]
            )
            ).toList(),
          ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_titleProgress),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh),
              onPressed: (){
                _getAllStatements();
              }
          ),
        ],
      ),
      body: Column(
        children: [
          _dataBody(),
        ],
      ),
    );
  }

}