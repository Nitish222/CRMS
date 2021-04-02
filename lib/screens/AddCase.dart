
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Services/Authenticate.dart';
import 'package:myapp/Services/CaseServices/Case.dart';
import 'package:myapp/Services/CaseServices/CaseAPI.dart';
import 'package:myapp/Services/Officer.dart';
import 'package:myapp/Services/Services.dart';
import 'package:myapp/Services/User.dart';
import 'package:myapp/screens/OfficerDash.dart';


class AddCase extends StatefulWidget{
  String user;
  AddCase({Key key,@required this.user}) : super(key: key);
  final String title = 'Add Case';
  @override
  _addCase_state createState() => _addCase_state();
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer
          .cancel(); // when the user is continuosly typing, this cancels the timer
    }
    // then we will start a new timer looking for the user to stop
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class _addCase_state extends State<AddCase>{
  List<Case> _case;
  List<Case> _filterCase;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _caseStatusController;
  TextEditingController _CaseDescriptionController;
  TextEditingController _statementIdController;
  TextEditingController _firIdController;
  TextEditingController _evidenceIdController;
  TextEditingController _officerIdController;
  final _debouncer = Debouncer(milliseconds: 2000);
  Case _selectCase;
  bool _isUpdating;
  bool _obscureText = true;
  String _titleProgress;
  String _chosenValue;
  void initState(){
    super.initState();
    //for users
    _case = [];
    _filterCase = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    _caseStatusController = TextEditingController();
    _CaseDescriptionController = TextEditingController();
    _firIdController = TextEditingController();
    _statementIdController = TextEditingController();
    _evidenceIdController = TextEditingController();
  }
  _createTable(){
    _showProgress('Creating Table....');
    CaseAPI.createTable().then((result)
    {
      if('success' == result){
        //show a snackbar
        _showSnackBar(context, result);
        _showProgress(widget.title);
      }});
  }
  _getAllCase(){
    _showProgress('Loading Case...');
    CaseAPI.getCase().then((cases){
      setState(() {
        _case = cases;
      });
      _showProgress(widget.title);
      print("Length ${cases.length}");
    });
  }
  _addCase(){
    _showProgress('Adding Case...');
    CaseAPI.addCase(_CaseDescriptionController.text,_caseStatusController.text,_evidenceIdController.text,
        _statementIdController.text, _firIdController.text,widget.user).then((result){
      if("success"==result){
        _getAllCase(); //Refresh the list
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
    _CaseDescriptionController.text = '';
    _statementIdController.text = '';
    _caseStatusController.text = '';
  }

  searchField() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
          hintText: 'Filter by First name or Last name',
        ),
        onChanged: (string) {
          // We will start filtering when the user types in the textfield.
          // Run the debouncer and start searching
          _debouncer.run(() {
            // Filter the original List and update the Filter list
            setState(() {
              _filterCase = _case.where((u) => (u.caseID
                  .toLowerCase()
                  .contains(string.toLowerCase())))
                  .toList();
            });
          });
        },
      ),
    );
  }

  //UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_titleProgress),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add),
              onPressed: (){
                _createTable();
              }
          ),
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.all(10.0),
                child:SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 30,
                  child: Form(
                    child: TextField(
                      controller: _CaseDescriptionController,
                      decoration: InputDecoration(
                        icon: const Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: const Icon(Icons.drive_file_rename_outline)),
                        hintText: 'Case Description',
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
                      controller: _statementIdController,
                      decoration: InputDecoration(
                        icon: const Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: const Icon(Icons.drive_file_rename_outline)),
                        hintText: 'StatementID',
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
                  child: new TextFormField(
                    controller: _caseStatusController,
                    decoration: const InputDecoration(
                        hintText: 'Case Status',
                        icon: const Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: const Icon(Icons.lock))),
                  ),
                )),
            Padding(
                padding: EdgeInsets.all(10.0),
                child:SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 30,
                  child: Form(
                    child: TextField(
                      controller: _firIdController,
                      decoration: InputDecoration(
                        icon: const Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: const Icon(Icons.local_police_outlined)),
                        hintText: 'Fir ID',
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
                      controller: _evidenceIdController,
                      decoration: InputDecoration(
                        icon: const Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: const Icon(Icons.local_police_outlined)),
                        hintText: 'Evidence ID',
                      ),
                    ),
                  ),
                )
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
                          child: Text('Add Case',style: TextStyle(fontSize: 20,color: Colors.black),),
                          onPressed: (){
                            _addCase();
                          },
                        )
                    )
                ),
                  // Padding(
                //     padding: EdgeInsets.only(left: 40.0,right: 40.0,top: 20.0,bottom: 20.0),
                //     child:SizedBox(
                //       width: MediaQuery.of(context).size.width*0.25,
                //       height: 40,
                //       child: ElevatedButton(
                //         style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                //           overlayColor: MaterialStateProperty.all<Color>(Colors.red),
                //         ),
                //         child: Text('View All Cases',style: TextStyle(fontSize: 20,color: Colors.black),),
                //         onPressed: (){
                //           _getAllCase();
                //         },
                //       ),
                //     )
                //  ),
                // _isUpdating
                //     ? Row(
                //   children: <Widget>[
                //     OutlineButton(
                //       child: Text('UPDATE'),
                //       onPressed: () {
                //         _updateCase(_selectCase);
                //       },
                //     ),
                //     OutlineButton(
                //       child: Text('CANCEL'),
                //       onPressed: () {
                //         setState(() {
                //           _isUpdating = false;
                //         });
                //         _clearValues();
                //       },
                //     ),
                //   ],
                // )
                //     : Container(),
                // searchField(),
                // // Expanded(
                // //   child: _dataBody(),
                // // ),

          ],
        ),
      ),
    );
  }
}