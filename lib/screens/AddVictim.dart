
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Services/CaseServices/Fir.dart';
import 'package:myapp/Services/CaseServices/FirAPI.dart';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';



class AddVictim extends StatefulWidget{
  String user;
  AddVictim() : super();
  final String title = 'Add Fir';
  @override
  _add_state createState() => _add_state();
}

class _add_state extends State<AddVictim>{
  List<Fir> _fir;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  //Fir_ID	Petitioner_ID	Victim_ID	Date_filed	Time_filed	Incident_date	Incident_location
  TextEditingController _victimIdController;
  TextEditingController _victimFirstNameController;
  TextEditingController _victimLastNameController;
  TextEditingController _victimContactController;
  TextEditingController _victimGenderController;
  TextEditingController _victimInjuriesController;
  TextEditingController _victimAddressController;
  TextEditingController _victimStatementIDController;
  TextEditingController _victimStatementController;
  bool _isUpdating;
  String _titleProgress;
  void initState(){
    super.initState();
    //for users
    _fir = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    _victimIdController = TextEditingController();
    _victimFirstNameController = TextEditingController();
    _victimLastNameController = TextEditingController();
    _victimAddressController = TextEditingController();

    _victimGenderController = TextEditingController();
    _victimInjuriesController = TextEditingController();
    _victimStatementIDController = TextEditingController();
    _victimStatementController = TextEditingController();

  }
  // _createTable(){
  //   _showProgress('Creating Table....');
  //   FirAPI.createTable().then((result)
  //   {
  //     if('success' == result){
  //       //show a snackbar
  //       _showSnackBar(context, result);
  //       _showProgress(widget.title);
  //     }});
  // }
  _getAllFir(){
    _showProgress('Loading Case...');
    FirAPI.getFir().then((firs){
      setState(() {
        _fir = firs;
      });
      _showProgress(widget.title);
      print("Length ${firs.length}");
    });
  }
  _addVictim(){
    _showProgress('Adding Victim...');
    FirAPI.addFir(_petitionerIdController.text,_victimIdController.text,_filedDateController,
        _timeController,_incidentDateController,_locationController.text).then((result){
      if("success"==result){
        _getAllFir(); //Refresh the list
        _clearValues();
      }
    });
  }

  _showProgress(String message){
    setState(() {
      _titleProgress = message;
    });
  }

  _showSnackBar(context,message){
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message),),);
  }

  //method to clear textfield
  _clearValues() {
    _victimIdController.text = '';
    _victimFirstNameController.text = '';
    _victimLastNameController.text = '';
    _victimAddressController.text = '';
    _victimGenderController.text = '';
    _victimInjuriesController.text = '';
    _victimStatementIDController.text = '';
    _victimStatementController.text = '';
  }

  //UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_titleProgress),
        actions: <Widget>[
          ElevatedButton(onPressed: (){

          }, child: Text('Add Victim')),
          ElevatedButton(onPressed: (){

          }, child: Text('Add Victim')),
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Fir_ID	Petitioner_ID	Victim_ID	Date_filed	Time_filed	Incident_date	Incident_location
            Padding(
                padding: EdgeInsets.all(10.0),
                child:SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 30,
                  child: Form(
                    child: TextField(
                      controller: _petitionerIdController,
                      decoration: InputDecoration(
                        icon: const Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: const Icon(Icons.drive_file_rename_outline)),
                        hintText: 'Petitioner ID',
                      ),
                    ),
                  ),
                )),
            Padding(
                padding: EdgeInsets.all(10.0),
                child:SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 30,
                  child: Form(
                    child: TextField(
                      controller: _victimIdController,
                      decoration: InputDecoration(
                        icon: const Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: const Icon(Icons.drive_file_rename_outline)),
                        hintText: 'Victim ID',
                      ),
                    ),
                  ),
                )
            ),
            Padding(
                padding: EdgeInsets.all(10.0),
                child:SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 30,
                  child: Form(
                    child: TextField(
                      controller: _locationController,
                      decoration: InputDecoration(
                        icon: const Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: const Icon(Icons.drive_file_rename_outline)),
                        hintText: 'Location',
                      ),
                    ),
                  ),
                )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

              ],
            ),
            Padding(
                padding: EdgeInsets.only(left: 40.0,right: 40.0,top: 20.0,bottom: 20.0),
                child:SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    child: ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                        overlayColor: MaterialStateProperty.all<Color>(Colors.red),
                      ),
                      child: Text('Add Fir',style: TextStyle(fontSize: 20,color: Colors.black),),
                      onPressed: (){
                        _addFir();
                      },
                    )
                )
            ),

          ],
        ),
      ),
    );
  }
}