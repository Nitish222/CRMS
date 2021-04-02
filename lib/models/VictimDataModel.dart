import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Services/CaseServices/Case.dart';
import 'package:myapp/Services/CaseServices/CaseAPI.dart';

class VictimDataModel extends StatefulWidget{
  VictimDataModel():super();
  final String title = 'Add Victim';
  @override
  _DataModel_State createState()=>_DataModel_State();

}


class _DataModel_State extends State<VictimDataModel>{
  List<Victim> _case;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isUpdating;
  String _titleProgress;
  @override
  void initState(){
    super.initState();
    //for users
    _victim = [];
    _titleProgress = widget.title;
  }
  _getAllVictim(){
    _showProgress('Loading Victim...');
    VictimAPI.getVictim().then((victims){
      setState(() {
        _victim = victims;
      });
      _showProgress(widget.title);
      print("Length ${victims.length}");
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
              DataColumn(label: Text('victim_id')),
              DataColumn(label: Text('first_name')),
              DataColumn(label: Text('last_name')),
              DataColumn(label: Text('contact')),
              DataColumn(label: Text('gender')),
              DataColumn(label: Text('injuries')),
              DataColumn(label: Text('victim_address')),
              DataColumn(label: Text('statement_id')),
            ],
            rows: _victim.map((victims)=> DataRow(
                cells: [
                  DataCell(Text(victims.victim_id)),
                  DataCell(Text(victims.first_name.toUpperCase())),
                  DataCell(Text(victims.last_name.toUpperCase())),
                  DataCell(Text(victims.contact)),
                  DataCell(Text(victims.gender)),
                  DataCell(Text(victims.injuries)),
                  DataCell(Text(victims.victim_address)),
                  DataCell(Text(victims.statement_id)),
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
                _getAllVictim();
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