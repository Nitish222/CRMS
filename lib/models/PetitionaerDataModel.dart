import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Services/Actors/PetitionerAPI.dart';
import 'package:myapp/Services/CaseServices/Case.dart';
import 'package:myapp/Services/CaseServices/CaseAPI.dart';
import 'package:myapp/Services/CaseServices/petitioner.dart';

class PetitionerDataModel extends StatefulWidget{
  PetitionerDataModel():super();
  final String title = 'Add Petitioner';
  @override
  _DataModel_State createState()=>_DataModel_State();

}


class _DataModel_State extends State<PetitionerDataModel>{
  List<Petitioner> _petitioner;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isUpdating;
  String _titleProgress;
  @override
  void initState(){
    super.initState();
    //for users
    _petitioner= [];
    _titleProgress = widget.title;
  }
  _getAllPetitioner(){
    _showProgress('Loading Petitioner...');
    PetitionerAPI.getPetitioner().then((petitioners){
      setState(() {
        _petitioner = petitioners;
      });
      _showProgress(widget.title);
      print("Length ${petitioners.length}");
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
        child:  DataTable(
                columns:[
                  DataColumn(label: Text('petitioner_id')),
                  DataColumn(label: Text('petitioner_first_name')),
                  DataColumn(label: Text('petitioner_last_name')),
                  DataColumn(label: Text('father_name')),
                  DataColumn(label: Text('petitioner_gender')),
                  DataColumn(label: Text('petitioner_contact')),
                  DataColumn(label: Text('petitioner_address')),
                ],
            rows: _petitioner.map((petitioners)=> DataRow(
                cells: [
                  DataCell(Text(petitioners.petitioner_id)),
                  DataCell(Text(petitioners.petitioner_first_name.toUpperCase())),
                  DataCell(Text(petitioners.petitioner_last_name.toUpperCase())),
                  DataCell(Text(petitioners.father_name)),
                  DataCell(Text(petitioners.petitioner_gender)),
                  DataCell(Text(petitioners.petitioner_contact))
                  //DataCell(Text(petitioners.petitioner_address)),
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
                _getAllPetitioner();
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