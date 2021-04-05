import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Services/CaseServices/Case.dart';
import 'package:myapp/Services/CaseServices/CaseAPI.dart';
import 'package:myapp/Services/CaseServices/petitioner.dart';
import 'package:myapp/models/AccusedDataModel.dart';
import 'package:myapp/models/EvidenceCategoryDataModel.dart';
import 'package:myapp/models/PetitionaerDataModel.dart';
import 'package:myapp/models/StatementsDataModel.dart';
import 'package:myapp/models/VictimDataModel.dart';
import 'package:myapp/screens/AddFir.dart';
import 'package:myapp/screens/OfficerDash.dart';

class CaseDetails extends StatefulWidget{
  CaseDetails():super();
  final String title = 'Case Details';
  @override
  _DataModel_State createState()=>_DataModel_State();

}


class _DataModel_State extends State<CaseDetails>{
  List<Case> _case;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isUpdating;
  String _titleProgress;
  TextEditingController _StatementController;
  TextEditingController _IDController;
  @override
  void initState(){
    super.initState();
    _StatementController = TextEditingController();
    //for users
    _case = [];
    _titleProgress = widget.title;
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
  // navigateToFirManagement(){
  //   Navigator.push(
  //       _scaffoldKey.currentContext,
  //       MaterialPageRoute(builder: (context) => AddFir(),
  //       ));
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_titleProgress),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh),
              onPressed: (){
              }
          ),
        ],
      ),
      body: Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
          SizedBox(height: 20.0),
          Text('Case Details', textAlign: TextAlign.center, style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
          DefaultTabController(
              length: 6, // length of tabs
              initialIndex: 0,
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
                Container(
                  child: TabBar(
                    labelColor: Colors.green,
                    unselectedLabelColor: Colors.black,
                    tabs: [
                      Tab(text: 'Fir Management'),
                      Tab(text: 'Victim Management'),
                      Tab(text: 'Petitioner Management'),
                      Tab(text: 'Evidence Management'),
                      Tab(text: 'Statenent Management'),
                      Tab(text: 'Accused Management'),
                    ],
                  ),
                ),
                Container(
                    height: 400, //height of TabBarView
                    decoration: BoxDecoration(
                        border: Border(top: BorderSide(color: Colors.grey, width: 0.5))
                    ),
                    child: TabBarView(children: <Widget>[
                      //CaseDataModel()
                      AddFir(),
                      VictimDataModel(),
                      PetitionerDataModel(),
                      EvidenceDataModel(),
                      StatementsDataModel(),
                      AccusedDataModel(),
                    ])
                )
              ])
          ),
        ]),
      ),
      );
  }

}