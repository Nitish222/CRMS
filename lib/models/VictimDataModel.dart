import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Services/Actors/StatementsAPI.dart';
import 'package:myapp/Services/Actors/VictimAPI.dart';
import 'package:myapp/Services/CaseServices/victim.dart';
import 'package:myapp/Services/EvidenceCategoryServices/Statement.dart';

class VictimDataModel extends StatefulWidget{
  VictimDataModel():super();
  final String title = 'Add Victim';
  @override
  _DataModel_State createState()=>_DataModel_State();

}


class _DataModel_State extends State<VictimDataModel>{
  List<Victim> _victim;
  List<Statement> _statement;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isUpdating;
  String _titleProgress;
  TextEditingController _victimIdController;
  TextEditingController _victimFirstNameController;
  TextEditingController _victimLastNameController;
  TextEditingController _victimContactController;
  String _victimGenderController;
  TextEditingController _victimInjuriesController;
  TextEditingController _victimAddressController;
  TextEditingController _victimStatementIDController;
  TextEditingController _victimStatementController;
  List<String> Gender = ["Male","Female","Binary","Trans"];
  @override
  void initState(){
    super.initState();
    //for users
    _victim = [];
    _statement = [];
    _titleProgress = widget.title;
    _victimIdController = TextEditingController();
    _victimFirstNameController = TextEditingController();
    _victimLastNameController = TextEditingController();
    _victimContactController = TextEditingController();
    _victimAddressController = TextEditingController();
    _victimInjuriesController = TextEditingController();
    _victimStatementIDController = TextEditingController();
    _victimStatementController = TextEditingController();
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
  _addVictim(){
    _showProgress('Adding Victim...');
    _addStatement();
    VictimAPI.addVictim(_victimFirstNameController.text,_victimLastNameController.text,
        _victimContactController.text,_victimGenderController,_victimInjuriesController.text,
        _victimAddressController.text).then((result){
      if("success"==result){
        _getAllVictim(); //Refresh the list
        _clearValues();
      }
    });
  }

  _getAllStatement(){
    _showProgress('Loading Statement...');
    StatementAPI.getStatement().then((statements){
      setState(() {
        _statement = statements;
      });
      _showProgress(widget.title);
      print("Length ${statements.length}");
    });
  }

  _addStatement(){
      _showProgress('Adding Statement...');
      StatementAPI.addStatement(_victimStatementController.text).then((result){
        if("success"==result){
          _getAllStatement(); //Refresh the list
          _clearValues();
        }
      });
  }

  _showProgress(String message){
    setState(() {
      _titleProgress = message;
    });
  }

  _clearValues() {
    _victimIdController.text = '';
    _victimFirstNameController.text = '';
    _victimLastNameController.text = '';
    _victimAddressController.text = '';
    _victimGenderController = '';
    _victimInjuriesController.text = '';
    _victimStatementIDController.text = '';
    _victimStatementController.text = '';
    _victimContactController.text = '';
  }

  SingleChildScrollView _dataBody(){
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
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
              DataColumn(label: Text('Update')),
              DataColumn(label: Text('Delete')),
              DataColumn(label: Text('View Details')),
            ],
            rows: _victim.map((victims)=> DataRow(
                cells: [
                  DataCell(Text(victims.victim_id.toString())),
                  DataCell( Text(victims.first_name.toString().toUpperCase()),),
                  DataCell(Text(victims.last_name.toString().toUpperCase())),
                  DataCell( Text(victims.contact.toString())),
                  DataCell(Text(victims.gender.toString().toUpperCase())),
                  DataCell(Text(victims.injuries.toString())),
                  DataCell(Text(victims.victim_address.toString().toUpperCase())),
                  DataCell(Text(victims.statement_id.toString())),
                  DataCell(ElevatedButton(onPressed: (){},child: Text('Update'),)),
                  DataCell(ElevatedButton(onPressed: (){},child: Text('Delete'),)),
                  DataCell(ElevatedButton(onPressed: (){},child: Text('View Victim Profile'),)),
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
          ElevatedButton(onPressed: (){
                showDialog(
                context: context,
                builder: (context)
                {
                  return Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      elevation: 16,
                      child: Container(
                        height: 800.0,
                        width: 600.0,
                        child: ListView(
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: SizedBox(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    height: 60,
                                    child: new TextFormField(
                                      controller: _victimFirstNameController,
                                      decoration: const InputDecoration(
                                          labelText: 'First Name',
                                          icon: const Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15.0),
                                              child: const Icon(
                                                  Icons.supervised_user_circle))),
                                    ),
                                  )),
                              Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: SizedBox(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    height: 60,
                                    child: new TextFormField(
                                      controller: _victimLastNameController,
                                      decoration: const InputDecoration(
                                          labelText: 'Last Name',
                                          icon: const Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15.0),
                                              child: const Icon(
                                                  Icons.supervised_user_circle))),
                                    ),
                                  )),
                              Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: SizedBox(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    height: 60,
                                    child: new TextFormField(
                                      controller: _victimContactController,
                                      decoration: const InputDecoration(
                                          labelText: 'Contact',
                                          icon: const Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15.0),
                                              child: const Icon(
                                                  Icons.supervised_user_circle))),
                                    ),
                                  )),
                              Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: SizedBox(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    height: 60,
                                    child:DropdownButton<String>(
                                        value: _victimGenderController,
                                        onChanged: (newValue){
                                          setState(() {
                                            _victimGenderController = newValue;
                                            print(_victimGenderController);
                                          }
                                          );
                                        },
                                        items: Gender.map((gender){ return DropdownMenuItem( value:gender , child: Text(gender));}
                                        ).toList(),
                                        hint:Text("Select Gender")
                                    ),
                                  )
                                  ),
                              Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: SizedBox(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    height: 60,
                                    child: new TextFormField(
                                      controller: _victimInjuriesController,
                                      decoration: const InputDecoration(
                                          labelText: 'Injuries',
                                          icon: const Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15.0),
                                              child: const Icon(
                                                  Icons.supervised_user_circle))),
                                    ),
                                  )),
                              Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: SizedBox(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    height: 60,
                                    child: new TextFormField(
                                      controller: _victimAddressController,
                                      decoration: const InputDecoration(
                                          labelText: 'Address',
                                          icon: const Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15.0),
                                              child: const Icon(
                                                  Icons.supervised_user_circle))),
                                    ),
                                  )),
                              Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: SizedBox(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    height: 60,
                                    child: new TextFormField(
                                      controller: _victimStatementController,
                                      decoration: const InputDecoration(
                                          labelText: 'Statement',
                                          icon: const Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15.0),
                                              child: const Icon(
                                                  Icons.supervised_user_circle))),
                                    ),
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(left: 40.0,
                                      right: 40.0,
                                      top: 20.0,
                                      bottom: 20.0),
                                  child: SizedBox(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width,
                                      height: 80,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty
                                              .all<Color>(Colors.green),
                                          overlayColor: MaterialStateProperty.all<
                                              Color>(Colors.red),
                                        ),
                                        child: Text('Submit', style: TextStyle(
                                            fontSize: 40, color: Colors.black),),
                                        onPressed: () {
                                          _addVictim();
                                        },
                                      )
                                  )
                              ),
                            ]
                        ),
                      )
                  );
                }
            );
          }, child: Text('Add Victim')),
          IconButton(icon: Icon(Icons.refresh),
              onPressed: (){
                _getAllVictim();
              },
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