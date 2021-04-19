import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Services/Actors/AccusedAPI.dart';
import 'package:myapp/Services/CaseServices/Accused.dart';


class AccusedDataModel extends StatefulWidget{
  AccusedDataModel():super();
  final String title = 'Add Accused';
  @override
  _DataModel_State createState()=>_DataModel_State();

}


class _DataModel_State extends State<AccusedDataModel>{
  List<Accused> _accused;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isUpdating;
  String _titleProgress;
  @override
  void initState(){
    super.initState();
    //for users
    _accused = [];
    _titleProgress = widget.title;
  }
  _getAllAccused(){
    _showProgress('Loading Accused...');
    AccusedAPI.getAccused().then((accuseds){
      setState(() {
        _accused = accuseds;
      });
      _showProgress(widget.title);
      print("Length ${accuseds.length}");
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
              DataColumn(label: Text('accused_id')),
              DataColumn(label: Text('first_name')),
              DataColumn(label: Text('last_name')),
              DataColumn(label: Text('contact')),
              DataColumn(label: Text('gender')),
              DataColumn(label: Text('criminal_records')),
              DataColumn(label: Text('accused_address')),
              DataColumn(label: Text('statement_id')),
            ],
            rows: _accused.map((accuseds)=> DataRow(
                cells: [
                  DataCell(Text(accuseds.accused_id.toString())),
                  DataCell(Text(accuseds.first_name.toString().toUpperCase())),
                  DataCell(Text(accuseds.last_name.toString().toUpperCase())),
                  DataCell(Text(accuseds.contact.toString())),
                  DataCell(Text(accuseds.gender.toString())),
                  DataCell(Text(accuseds.criminal_records.toString())),
                  DataCell(Text(accuseds.accused_address.toString())),
                  DataCell(Text(accuseds.statement_id.toString())),
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
        automaticallyImplyLeading: false,
        title: Text(_titleProgress),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh),
              onPressed: (){
                _getAllAccused();
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