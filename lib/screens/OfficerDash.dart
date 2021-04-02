
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Services/Officer.dart';
import 'package:myapp/Services/Services.dart';
import 'package:myapp/models/CaseDataModel.dart';
import 'package:myapp/models/EvidenceDataModel.dart';
import 'package:myapp/models/FirDataModel.dart';
import 'package:myapp/screens/AddCase.dart';

class OfficerDash extends StatefulWidget{
  final String user;
  OfficerDash({Key key,@required this.user}) : super(key: key);
  final String title = 'Officer Dashboard';
  @override
  _dashboard_state createState() => _dashboard_state();

}

// ignore: camel_case_types
class _dashboard_state extends State<OfficerDash>{
  List<Officer> _officer;
  GlobalKey<ScaffoldState> _scaffoldKey;
  TextEditingController _firstNameController; //controller for the first name
  TextEditingController _lastNameController; //controller for the last name
  Officer _selectOfficer;
  bool _isUpdating;
  String _titleProgress;
  @override
  void initState(){
    super.initState();
    _officer = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
  }

  //Method to update title

  _showProgress(String message){
    setState(() {
      _titleProgress = message;
    });
  }

  _showSnackBar(context,message){
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message),),);
  }
  _createTable(){
    _showProgress('Creating Table....');
    Services.createTable().then((result)
    {
      if('success' == result){
        //show a snackbar
        _showSnackBar(context, result);
        _showProgress(widget.title);
      }});
    }

  _getOfficer(){
      _showProgress('Loading Officers...');
      Services.getOfficers().then((officers){
        setState(() {
          _officer = officers;
        });
        _showProgress(widget.title);
        print("Length ${officers.length}");
      });
  }

  _deleteOfficer(Officer officer){
      _showProgress('Deleting Employees....');
      Services.deleteOfficer(officer.officerID).then((result){
        if("success" == result){
            _getOfficer(); //Refresh after delete...
        }
      });
  }

  //method to clear textfield
  _clearValues() {
    _firstNameController.text  ='';
    _lastNameController.text = '';
  }

  // Let's create a DataTable and show in the officers list
  SingleChildScrollView _dataBody(){
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns:[
            DataColumn(label: Text('Officer_ID')),
            DataColumn(label: Text('First Name')),
            DataColumn(label: Text('Last Name'))
          ],
          rows: _officer.map((officer)=> DataRow(
            cells: [
              DataCell(Text(officer.officerID)),
              DataCell(Text(officer.firstName.toUpperCase())),
              DataCell(Text(officer.lastName.toUpperCase())),
          ]
          )
          ).toList(),
        ),
      ),
    );
  }

  //UI
  @override
  Widget build(BuildContext context){
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_titleProgress),
        elevation: .1,
        backgroundColor: Color.fromRGBO(49, 87, 110, 1.0),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add),
              onPressed: (){
                _createTable();
              }
          ),
          IconButton(icon: Icon(Icons.refresh),
              onPressed: (){
                _getOfficer();
              }
          ),
        ],
      ),
      drawer:  Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: CircleAvatar(
                backgroundImage: NetworkImage('https://www.delhipolice.nic.in/dp-img/Sh.jpg'),
              )
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () {
                int count = 0;
                Navigator.of(context).popUntil((_) => count++ >= 2);
              },
            ),
            ListTile(
              title: Text('Back'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
          SizedBox(height: 20.0),
          Text('Officer Dashboard', textAlign: TextAlign.center, style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
          DefaultTabController(
              length: 4, // length of tabs
              initialIndex: 0,
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
                Container(
                  child: TabBar(
                    labelColor: Colors.green,
                    unselectedLabelColor: Colors.black,
                    tabs: [
                      Tab(text: 'Retrieve Case Details'),
                      Tab(text: 'Retrieve Recent FIRs'),
                      Tab(text: 'Add new Case'),
                      Tab(text: 'View Evidence Category and Item Details'),
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
                      CaseDataModel(),
                      FirDataModel(),
                      AddCase(user: widget.user),
                      //ItemTypeDataModel()
                      EvidenceDataModel(),
                    ])
                )
              ])
          ),
        ]),
      ),
    );
  }
}

