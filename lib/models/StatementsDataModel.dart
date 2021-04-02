import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Services/CaseServices/Case.dart';
import 'package:myapp/Services/CaseServices/CaseAPI.dart';

class StatementsDataModel extends StatefulWidget{
  StatementsDataModel():super();
  final String title = 'Add Statements';
  @override
  _DataModel_State createState()=>_DataModel_State();

}


class _DataModel_State extends State<StatementsDataModel>{
  List<Case> _case;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isUpdating;
  String _titleProgress;
  @override
  void initState(){
    super.initState();
    //for users
    _case = [];
    _titleProgress = widget.title;
  }
  _getAllStatements(){
    _showProgress('Loading Statements...');
    StatementAPI.getStatements().then((statementss){
      setState(() {
        _statements = statementss;
      });
      _showProgress(widget.title);
      print("Length ${statementss.length}");
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
        child: Align(
          alignment: Align.,
          child: DataTable(
            columns:[
              DataColumn(label: Text('statement_id')),
              DataColumn(label: Text('statements')),
            ],
            rows: _statements.map((statementsss)=> DataRow(
                cells: [
                  DataCell(Text(statementss.statement_id)),
                  DataCell(Text(statementss.statements.toUpperCase())),

                ]
            )
            ).toList(),
          ),
        )
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