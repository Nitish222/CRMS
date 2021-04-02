
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Services/Authenticate.dart';
import 'package:myapp/Services/Officer.dart';
import 'package:myapp/Services/Services.dart';
import 'package:myapp/Services/User.dart';
import 'package:myapp/screens/OfficerDash.dart';


class Register extends StatefulWidget{
  Register() : super();
  final String title = 'SignUp';
  @override
  _register_state createState() => _register_state();
}

class _register_state extends State<Register>{
  List<User> _user;
  List<Officer> _officer;
  GlobalKey<ScaffoldState> _scaffoldKey;
  TextEditingController _userPassController;
  TextEditingController _firstNameController;
  TextEditingController _lastNameController;
  TextEditingController _userRankController;
  Officer _selectOfficer;
  User _selectUser;
  bool _isUpdating;
  bool _obscureText = true;
  String _titleProgress;
  String _chosenValue;
  void initState(){
    super.initState();
    //for users
    _user = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    _userPassController = TextEditingController();
    _firstNameController = TextEditingController();
    _userRankController = TextEditingController();
    _lastNameController = TextEditingController();
    //for officers
    _officer = [];

  }

  _createTable(){
    _showProgress('Creating Table....');
    Authenticate.createTable().then((result)
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
  _addOfficer(){
    _showProgress('Adding User...');
    Services.addOfficer(_firstNameController.text, _lastNameController.text, _userRankController.text).then((result){
      if("success"==result){
        _getOfficer(); //Refresh the list
        _clearValues();
      }
    });
  }

  _registerUser(){
    if(_userPassController.text.isEmpty||_firstNameController.text.isEmpty||_lastNameController.text.isEmpty){
      print("empty fields");
      return;
    }
    _showProgress('Adding Officer...');
    Authenticate.register( _userPassController.text,_userRankController.text).then((result){
      if("success"==result){//Refresh the list
        _addOfficer();
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
    _firstNameController.text = '';
    _lastNameController.text = '';
    _userPassController.text = '';
    _userRankController.text = '';
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
            Row(
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Center(child:Image.network(
                          'https://static.toiimg.com/photo/62852551.cms',
                          fit: BoxFit.cover
                      ))
                  ),
                )
              ],
            ),
            Padding(
                padding: EdgeInsets.all(10.0),
                child:SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 30,
                  child: Form(
                    child: TextField(
                      controller: _firstNameController,
                      decoration: InputDecoration(
                      icon: const Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: const Icon(Icons.drive_file_rename_outline)),
                        hintText: 'First Name',
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
                      controller: _lastNameController,
                      decoration: InputDecoration(
                        icon: const Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: const Icon(Icons.drive_file_rename_outline)),
                        hintText: 'Last Name',
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
                    controller: _userPassController,
                    decoration: const InputDecoration(
                        hintText: 'Password',
                        icon: const Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: const Icon(Icons.lock))),
                    validator: (val) => val.length < 6 ? 'Password too short.' : null,
                    onSaved: (val) => _userPassController,
                    obscureText: _obscureText,
                  ),
                )),
            Padding(
                padding: EdgeInsets.all(10.0),
                child:SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 30,
                  child: Form(
                    child: TextField(
                      controller: _userRankController,
                      decoration: InputDecoration(
                        icon: const Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: const Icon(Icons.local_police_outlined)),
                        hintText: 'Rank',
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
                      child: Text('Register',style: TextStyle(fontSize: 20,color: Colors.black),),
                      onPressed: (){
                        _registerUser();
                      },
                    )
                )
            ),
          ],
        ),
      ),

    );
    // TODO: implement build
    throw UnimplementedError();
  }
}