import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Services/CaseServices/Case.dart';
import 'package:myapp/Services/CaseServices/CaseAPI.dart';
import 'package:myapp/Services/CaseServices/FirAPI.dart';
import 'package:myapp/Services/CaseServices/Fir.dart';

class FirDataModel extends StatefulWidget{
  FirDataModel():super();
  final String title = 'Retrieve FIR';
  @override
  _DataModel_State createState()=>_DataModel_State();

}
class _DataModel_State extends State<FirDataModel>{
  List<Fir> _fir;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // TextEditingController _victimIdController;
  // TextEditingController _petitionerIdController;
  TextEditingController _locationController;
  String _incidentDateController;
  String _timeController;
  String _filedDateController;
  bool _isUpdating;
  DateTime selectedDate;
  String _titleProgress;
  @override
  void initState(){
    super.initState();
    //for users
    _fir = [];
    _titleProgress = widget.title;
    _locationController = TextEditingController();
  }
  _getAllFir(){
    _showProgress('Loading FIR...');
    FirAPI.getFir().then((firs){
      setState(() {
        _fir = firs;
      });
      _showProgress(widget.title);
      print("Length ${firs.length}");
    });
  }
  _deleteFir(Fir firs){
    _showProgress('Deleting Employees....');
    print("id is:"+firs.fir_id);
    FirAPI.deleteFir(firs.fir_id).then((result){
      if("success" == result){
        _getAllCase(); //Refresh after delete...
      }
    });
  }

  _getAllCase(){
    _showProgress('Loading Case...');
    FirAPI.getFir().then((firs){
      setState(() {
        _fir = firs;
      });
      _showProgress(widget.title);
      print("Length ${firs.length}");
    });
  }

  _clearValues(){
    _locationController.text = '';
    _incidentDateController = '';
  }

  _updateFir(String caseID){
    setState(() {
      _isUpdating = true;
    });
    String des= _locationController.text;
    print(caseID+" "+des+" "+_incidentDateController);
    _showProgress('Updating Employees....');
    FirAPI.updateFir(_incidentDateController,_locationController.text).then((result){
      if("success" == result){
        _getAllCase(); //Refresh the list after update
        setState(() {
          _isUpdating = false;
        });
        _clearValues();
      }
    });

  }

  _showProgress(String message){
    setState(() {
      _titleProgress = message;
    });
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
              //DataColumn(label: Text('Open')),
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
                  DataCell(ElevatedButton(child: Text('UPDATE'),onPressed: (){ showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                            elevation: 16,
                            child: Container(
                              height: 400.0,
                              width: 360.0,
                              child:  ListView(
                                  children: <Widget>[
                                    Padding(
                                        padding: EdgeInsets.all(20.0),
                                        child:SizedBox(
                                          width: MediaQuery.of(context).size.width,
                                          height: 60,
                                          child: new TextFormField(
                                            controller: _locationController,
                                            decoration: const InputDecoration(
                                                labelText: 'New Location',
                                                icon: const Padding(
                                                    padding: const EdgeInsets.only(top: 15.0),
                                                    child: const Icon(Icons.supervised_user_circle))),
                                          ),
                                        )),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
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
                                            height: 80,
                                            child: ElevatedButton(
                                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                                overlayColor: MaterialStateProperty.all<Color>(Colors.red),
                                              ),
                                              child: Text('Submit',style: TextStyle(fontSize: 40,color: Colors.black),),
                                              onPressed: (){
                                                // print(_CaseStatusController.text+" "+_CaseDescController.text+" ");
                                                // print(cases.caseID);
                                                _updateFir(firs.fir_id.toString());
                                              },
                                            )
                                        )
                                    ),
                                  ]
                              ),
                            )
                        );
                      }); },)),
                  DataCell(ElevatedButton(child: Text('DELETE'),onPressed: (){ _deleteFir(firs); },)),
                  //DataCell(ElevatedButton(child: Text('VIEW CASE'),onPressed: (){ navigateToCaseDetailsDashboard(); },)),
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
        automaticallyImplyLeading: false,
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