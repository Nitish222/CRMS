import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Services/CaseServices/Case.dart';
import 'package:myapp/Services/CaseServices/CaseAPI.dart';
import 'package:myapp/Services/CaseServices/Evidence.dart';
import 'package:myapp/Services/CaseServices/EvidenceAPI.dart';

class EvidenceDataModel extends StatefulWidget{
  EvidenceDataModel():super();
  final String title = 'Add Evidence';
  @override
  _DataModel_State createState()=>_DataModel_State();

}


class _DataModel_State extends State<EvidenceDataModel>{
  List<Evidence> _evidence;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isUpdating;
  String _titleProgress;
  @override
  void initState(){
    super.initState();
    //for users
    _evidence = [];
    _titleProgress = widget.title;
  }
  _getAllEvidence(){
    _showProgress('Loading Evidence...');
    EvidenceAPI.getEvidence().then((evidences){
      setState(() {
        _evidence = evidences;
      });
      _showProgress(widget.title);
      print("Length ${evidences.length}");
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
              DataColumn(label: Text('evidence_id')),
              DataColumn(label: Text('category_id')),
              DataColumn(label: Text('item_description')),
              DataColumn(label: Text('item_quantity')),
              DataColumn(label: Text('Update')),
              DataColumn(label: Text('Delete')),
              DataColumn(label: Text('Open')),
            ],
            rows: _evidence.map((evidences)=> DataRow(
                cells: [
                  DataCell(Text(evidences.evidence_id)),
                  DataCell(Text(evidences.category_id.toUpperCase())),
                  DataCell(Text(evidences.item_description.toUpperCase())),
                  DataCell(Text(evidences.item_quantity)),
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
                                            //controller: _CaseDescController,
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
                                            //controller: _CaseStatusController,
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

                                              },
                                            )
                                        )
                                    ),
                                  ]
                              ),
                            )
                        );
                      }); },)),
                  DataCell(ElevatedButton(child: Text('DELETE'),onPressed: (){ },)),
                  DataCell(ElevatedButton(child: Text('VIEW DETAILS'),onPressed: (){  },)),
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
                _getAllEvidence();
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