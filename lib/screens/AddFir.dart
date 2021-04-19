
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Services/CaseServices/Fir.dart';
import 'package:myapp/Services/CaseServices/FirAPI.dart';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';



class AddFir extends StatefulWidget{
  String user;
  AddFir() : super();
  final String title = 'Add Fir';
  @override
  _addFir_state createState() => _addFir_state();
}

class _addFir_state extends State<AddFir>{
  List<Fir> _fir;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  //Fir_ID	Petitioner_ID	Victim_ID	Date_filed	Time_filed	Incident_date	Incident_location
  TextEditingController _victimIdController;
  TextEditingController _petitionerIdController;
  TextEditingController _locationController;
  String _incidentDateController;
  String _timeController;
  String _filedDateController;
  String _setTime, _setDate;
  String _hour, _minute, _time;
  double _height,_width;
  String dateTime;
  DateTime selectedDate;
  TimeOfDay selectedTime;
  Fir _selectFir;
  var now;
  bool _isUpdating;
  bool _obscureText = true;
  String _titleProgress;
  String _chosenValue;
  void initState(){
    super.initState();
    //for users
    _fir = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    selectedDate = DateTime.now();
    selectedTime = TimeOfDay.now();
    _victimIdController = TextEditingController();
    _petitionerIdController = TextEditingController();
    _locationController = TextEditingController();
    _incidentDateController = formatDate(selectedDate, [yyyy, '-', mm, '-', dd]);
    _filedDateController = formatDate(selectedDate, [yyyy, '-', mm, '-', dd]);
    _timeController = formatDate(selectedDate, [HH, ':', mm, ':', ss]);

  }
  _createTable(){
    _showProgress('Creating Table....');
    FirAPI.createTable().then((result)
    {
      if('success' == result){
        //show a snackbar
        _showSnackBar(context, result);
        _showProgress(widget.title);
      }});
  }
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
  _addFir(){
    //++++
    //print(_petitionerIdController.text);
   //print(_victimIdController.text);
    print(_locationController.text);
    //print(_filedDateController);
    //print(_timeController);
    //print(_incidentDateController);
    _showProgress('Adding Case...');
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
    _petitionerIdController.text = '';
    _victimIdController.text = '';
    _locationController.text = '';
    _incidentDateController = '';
    _timeController = '';
    _filedDateController = '';
  }

  _pickDate() async {
    DateTime date = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(DateTime.now().year-5),
                  lastDate: DateTime(DateTime.now().year+5)
    );
    if(date != null){
      setState(() {
        selectedDate = date;
      });
    }
  }

  _picktime(){
    now = DateTime.now();
    _timeController = DateFormat('HH:mm:ss').format(now).toString();
  }


  //UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                        Row(
                          children: [
                            Padding(padding: EdgeInsets.only(left: 20),
                                child:Text(("DATE FILED: ${selectedDate.year},${selectedDate.month},${selectedDate.day}"),
                                  style: TextStyle(fontSize: 20),)
                            ),
                            ElevatedButton(onPressed: (){
                                    _pickDate();
                                    _filedDateController = formatDate(selectedDate, [yyyy, '-', mm, '-', dd]);
                            }, child: Text('Add Date'),),// IconButton(icon: Icon(Icons.keyboard_arrow_down),onPressed: _pickDate,)
                          ],
                        ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 20),
                        child:Text(("Time FILED: ${_timeController},${selectedDate.timeZoneName}"),
                          style: TextStyle(fontSize: 20),)
                    ),
                    ElevatedButton(onPressed: (){_picktime();
                    //print(_timeController);
                    },
                        child: Text('Get current Time'))
                  ],
                ),
                Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 20),
                        child:Text(("INCIDENT DATE: ${selectedDate.year},${selectedDate.month},${selectedDate.day}"),
                          style: TextStyle(fontSize: 20),)
                    ),
                    ElevatedButton(onPressed: (){
                      _pickDate();
                      _incidentDateController = formatDate(selectedDate, [yyyy, '-', mm, '-', dd]);
                    },child: Text('Add Date')),// IconButton(icon: Icon(Icons.keyboard_arrow_down),onPressed: _pickDate,)
                  ],
                )
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