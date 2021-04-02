import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Services/CaseServices/Case.dart';
import 'package:myapp/Services/CaseServices/FirAPI.dart';
import 'package:myapp/Services/CaseServices/Fir.dart';

class FirDataModel extends StatefulWidget{
  FirDataModel():super();
  final String title = 'Add FIR';
  @override
  _DataModel_State createState()=>_DataModel_State();

}


class _DataModel_State extends State<FirDataModel>{
  List<FIR> _fir;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isUpdating;
  String _titleProgress;
  @override
  void initState(){
    super.initState();
    //for users
    _fir = [];
    _titleProgress = widget.title;
  }
  _getAllFir(){
    _showProgress('Loading FIR...');
    FirAPI.getFir().then((firs){
      setState(() {
        _fir = firs.cast<FIR>();
      });
      _showProgress(widget.title);
      print("Length ${firs.length}");
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
              DataColumn(label: Text('fir_id')),
              DataColumn(label: Text('petitioner_id')),
              DataColumn(label: Text('victim_id')),
              DataColumn(label: Text('date_filed')),
              DataColumn(label: Text('time_filed')),
              DataColumn(label: Text('incident_date')),
              DataColumn(label: Text('incident_location')),
              DataColumn(label: Text('Update')),
              DataColumn(label: Text('Delete')),
              DataColumn(label: Text('Open')),
            ],
            rows: _fir.map((firs)=> DataRow(
                cells: [
                  DataCell(Text(firs.fir_id)),
                  DataCell(Text(firs.petitioner_id.toUpperCase())),
                  DataCell(Text(firs.victim_id.toUpperCase())),
                  DataCell(Text(firs.date_filed)),
                  DataCell(Text(firs.time_filed)),
                  DataCell(Text(firs.incident_date)),
                  DataCell(Text(firs.incident_location)),
                ]
            )
            ).toList(),
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
                _getAllFir();
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