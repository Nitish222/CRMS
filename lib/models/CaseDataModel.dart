import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Services/CaseServices/Case.dart';
import 'package:myapp/Services/CaseServices/CaseAPI.dart';
import 'package:myapp/screens/CaseDetails.dart';

class CaseDataModel extends StatefulWidget{
  CaseDataModel():super();
  final String title = 'Retrieve Case';
  @override
  _DataModel_State createState()=>_DataModel_State();

}


class _DataModel_State extends State<CaseDataModel>{
  List<Case> _case;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isUpdating;
  String _titleProgress;
  TextEditingController _CaseDescController;
  TextEditingController _CaseStatusController;
  Case _selectedCase;
  @override
  void initState(){
    super.initState();
    //for users
    _case = [];
    _titleProgress = widget.title;
    _CaseDescController = TextEditingController();
    _CaseStatusController = TextEditingController();
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
  _showProgress(String message){
    setState(() {
      _titleProgress = message;
    });
  }
  navigateToCaseDetailsDashboard(){
    Navigator.push(
        _scaffoldKey.currentContext,
        MaterialPageRoute(builder: (context) => CaseDetails(),
        ));
  }
  _updateCase(String caseID){
        setState(() {
          _isUpdating = true;
        });
        String des= _CaseDescController.text;
        String sta = _CaseStatusController.text;
        print(caseID+" "+des+" "+sta);
        _showProgress('Updating Case....');
        CaseAPI.updateCase(caseID, _CaseDescController.text, _CaseStatusController.text).then((result){
          if("success" == result){
              _getAllCase(); //Refresh the list after update
              setState(() {
                _isUpdating = false;
              });
              _clearValues();
          }
      });

  }
  _deleteCase(Case Cases){
    _showProgress('Deleting Case....');
    print("id is:"+Cases.caseID);
    CaseAPI.deleteCase(Cases.caseID).then((result){
      if("success" == result){
        _getAllCase(); //Refresh after delete...
      }
    });
  }
  _clearValues(){
    _CaseStatusController.text = '';
    _CaseDescController.text = '';
  }

  SingleChildScrollView _dataBody(){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Center(
        child: DataTable(
          columns:[
            DataColumn(label: Text('Case_ID')),
            DataColumn(label: Text('case_status')),
            DataColumn(label: Text('case_description')),
            DataColumn(label: Text('statement_id')),
            DataColumn(label: Text('evidence_id')),
            DataColumn(label: Text('fir_id')),
            DataColumn(label: Text('officer_id')),
            DataColumn(label: Text('Update')),
            DataColumn(label: Text('Delete')),
            DataColumn(label: Text('Open')),
          ],
          rows: _case.map((cases)=> DataRow(
              cells: [
                DataCell(Container(child:Text(cases.caseID))),
                DataCell(Text(cases.case_status.toUpperCase())),
                DataCell(Text(cases.case_description.toUpperCase())),
                DataCell(Text(cases.statement_id)),
                DataCell(Text(cases.evidence_id)),
                DataCell(Text(cases.fir_id)),
                DataCell(Text(cases.officer_id)),
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
                                          controller: _CaseDescController,
                                          decoration: const InputDecoration(
                                              labelText: 'New CaseDescription',
                                              icon: const Padding(
                                                  padding: const EdgeInsets.only(top: 15.0),
                                                  child: const Icon(Icons.supervised_user_circle))),
                                        ),
                                      )),
                                  Padding(
                                      padding: EdgeInsets.all(20.0),
                                      child:SizedBox(
                                        width: MediaQuery.of(context).size.width,
                                        height: 60,
                                        child: new TextFormField(
                                          controller: _CaseStatusController,
                                          decoration: const InputDecoration(
                                              labelText: 'New Case Status',
                                              icon: const Padding(
                                                  padding: const EdgeInsets.only(top: 15.0),
                                                  child: const Icon(Icons.supervised_user_circle))),
                                        ),
                                      )),
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
                                              print(_CaseStatusController.text+" "+_CaseDescController.text+" ");
                                              print(cases.caseID);
                                              _updateCase(cases.caseID.toString());
                                            },
                                          )
                                      )
                                  ),
                                ]
                            ),
                          )
                      );
                    }); },)),
                DataCell(ElevatedButton(child: Text('DELETE'),onPressed: (){ _deleteCase(cases); },)),
                DataCell(ElevatedButton(child: Text('VIEW DETAILS'),onPressed: (){ navigateToCaseDetailsDashboard(); },)),
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
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh),
              onPressed: (){
                _getAllCase();
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