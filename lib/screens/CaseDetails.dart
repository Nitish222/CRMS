import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Services/CaseServices/Case.dart';
import 'package:myapp/Services/CaseServices/CaseAPI.dart';
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

  _addStatements(){

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
              }
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(40.0),
          child: Column(
            children: <Widget>[
              Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  image: DecorationImage(
                    image: NetworkImage('https://static.toiimg.com/photo/62852551.cms'),
                    fit: BoxFit.fitHeight,
                  )
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      colors: [
                        Colors.orange.withOpacity(.5),
                        Colors.white.withOpacity(.5),
                        Colors.green.withOpacity(.5),
                      ]
                    )
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(padding: EdgeInsets.only(left:100),
                    child: Column(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(left: 40.0,right: 40.0,top: 20.0,bottom: 20.0),
                            child:SizedBox(
                                width: MediaQuery.of(context).size.width*0.30,
                                height: 100,
                                child: ElevatedButton(
                                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                    overlayColor: MaterialStateProperty.all<Color>(Colors.red),
                                  ),
                                  child: Text('Statements Management',style: TextStyle(fontSize: 20,color: Colors.black),textAlign: TextAlign.center,),
                                  onPressed: (){
                                      showDialog(
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
                                                height: 40,
                                                child: new TextFormField(
                                                  controller: _IDController,
                                                  decoration: const InputDecoration(
                                                      labelText: 'ID',
                                                      icon: const Padding(
                                                          padding: const EdgeInsets.only(top: 15.0),
                                                          child: const Icon(Icons.supervised_user_circle))),
                                                ),
                                              )),
                                          Padding(
                                              padding: EdgeInsets.all(20.0),
                                              child:SizedBox(
                                                width: MediaQuery.of(context).size.width,
                                                height: 40,
                                                child: new TextFormField(
                                                  controller: _StatementController,
                                                  decoration: const InputDecoration(
                                                      labelText: 'Statement',
                                                      icon: const Padding(
                                                          padding: const EdgeInsets.only(top: 15.0),
                                                          child: const Icon(Icons.supervised_user_circle))),
                                                ),
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(left: 40.0,right: 40.0,top: 20.0,bottom: 20.0),
                                              child:SizedBox(
                                                  width: MediaQuery.of(context).size.width,
                                                  height: 100,
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                                      overlayColor: MaterialStateProperty.all<Color>(Colors.red),
                                                    ),
                                                    child: Text('Submit',style: TextStyle(fontSize: 20,color: Colors.black),),
                                                    onPressed: (){
                                                      _addStatements();
                                                    },
                                                  )
                                              )
                                          ),
                                          ]
                                        ),
                                      )
                                      );
                                      });
                                  },
                                )
                            )
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 40.0,right: 40.0,top: 20.0,bottom: 20.0),
                            child:SizedBox(
                                width: MediaQuery.of(context).size.width*0.30,
                                height: 100,
                                child: ElevatedButton(
                                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                    overlayColor: MaterialStateProperty.all<Color>(Colors.red),
                                  ),
                                  child: Text('Victim Management',style: TextStyle(fontSize: 20,color: Colors.black),),
                                  onPressed: (){
                                      //_updateCase();
                                  },
                                )
                            )
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 40.0,right: 40.0,top: 20.0,bottom: 20.0),
                            child:SizedBox(
                                width: MediaQuery.of(context).size.width*0.30,
                                height: 100,
                                child: ElevatedButton(
                                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                    overlayColor: MaterialStateProperty.all<Color>(Colors.red),
                                  ),
                                  child: Text('Conduct Investigation',style: TextStyle(fontSize: 20,color: Colors.black),),
                                  onPressed: (){

                                  },
                                )
                            )
                        ),
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left:100),
                    child: Column(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(left: 40.0,right: 40.0,top: 20.0,bottom: 20.0),
                            child:SizedBox(
                                width: MediaQuery.of(context).size.width*0.30,
                                height: 100,
                                child: ElevatedButton(
                                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                    overlayColor: MaterialStateProperty.all<Color>(Colors.red),
                                  ),
                                  child: Text('Officer Management',style: TextStyle(fontSize: 20,color: Colors.black),),
                                  onPressed: (){

                                  },
                                )
                            )
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 40.0,right: 40.0,top: 20.0,bottom: 20.0),
                            child:SizedBox(
                                width: MediaQuery.of(context).size.width*0.30,
                                height: 100,
                                child: ElevatedButton(
                                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                    overlayColor: MaterialStateProperty.all<Color>(Colors.red),
                                  ),
                                  child: Text('Accused Management',style: TextStyle(fontSize: 20,color: Colors.black),),
                                  onPressed: (){

                                  },
                                )
                            )
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 40.0,right: 40.0,top: 20.0,bottom: 20.0),
                            child:SizedBox(
                                width: MediaQuery.of(context).size.width*0.30,
                                height: 100,
                                child: ElevatedButton(
                                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                    overlayColor: MaterialStateProperty.all<Color>(Colors.red),
                                  ),
                                  child: Text('Petitioner Management',style: TextStyle(fontSize: 20,color: Colors.black),),
                                  onPressed: (){

                                  },
                                )
                              )
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              )
          ),

        )
      );
  }

}