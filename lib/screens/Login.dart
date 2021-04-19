
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Services/Authenticate.dart';
import 'package:myapp/Services/Officer.dart';
import 'package:myapp/Services/User.dart';
import 'package:myapp/screens/OfficerDash.dart';
import 'package:myapp/screens/Register.dart';

class Login extends StatefulWidget{
  Login() : super();
  final String title = 'Officer Dashboard';
  @override
  _dashboard_state createState() => _dashboard_state();

}

// ignore: camel_case_types
class _dashboard_state extends State<Login>{
  List<User> _user;
  final GlobalKey<ScaffoldState> _scaffoldKey= GlobalKey<ScaffoldState>();
  TextEditingController _userIdController; //controller for the first name
  TextEditingController _userPassController; //controller for the last name
  Officer _selectOfficer;
  bool _isUpdating = false;
  bool _obscureText = true;
  String _titleProgress;
  String currentUserId;
  List<String> response;
  @override
  void initState(){
    super.initState();
    _user = [];
    // _isUpdating = false;
    // _obscureText = true;
    _titleProgress = widget.title;
    _userPassController = TextEditingController();
    _userIdController = TextEditingController();
  }

  //Method to update title

  _showProgress(String message){
    setState(() {
      _titleProgress = message;
    });
  }

  _showSnackBar(message){
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message),),);
  }
  _loginUser(){
    //print(_userPassController.text);
    _showProgress('Logging in...');
    Authenticate.login(_userIdController.text,_userPassController.text).then((message){
      setState(() {
        if(message=="Create Account!!") {
          _showSnackBar(message);
          navigateToRegister();
        }
        else{
          if(message=="incorrect password"){
            _showSnackBar(message);
          }
          else if(message == "success"){
            _showSnackBar(message);
            currentUserId= _userIdController.text;
            navigateToDashboard(currentUserId);
          }
        }
      });
      _showProgress(widget.title);
    });
  }

  navigateToRegister(){
    Navigator.push(
        _scaffoldKey.currentContext,
        MaterialPageRoute(builder: (context) => Register(),
    ));
  }
  navigateToDashboard(String userId){
    Navigator.push(
        _scaffoldKey.currentContext,
        MaterialPageRoute(builder: (context) => OfficerDash(user: userId),
        ));
  }

  //method to clear textfield
  _clearValues() {
    _userIdController.text  ='';
    _userPassController.text = '';
  }
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  //UI

  @override
  Widget build(BuildContext context){
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_titleProgress),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add),
              onPressed: (){
              }
          ),
          IconButton(icon: Icon(Icons.refresh),
              onPressed: (){
                //_getOfficer();
              }
          ),
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
                padding: EdgeInsets.all(20.0),
                child:SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: new TextFormField(
                    controller: _userIdController,
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
                  height: 100,
                  child: new TextFormField(
                    controller: _userPassController,
                    decoration: const InputDecoration(
                        labelText: 'Password',
                        icon: const Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: const Icon(Icons.lock))),
                    validator: (val) => val.length < 6 ? 'Password too short.' : null,
                    onSaved: (val) => _userPassController,
                    obscureText: _obscureText,
                  ),
                )),

            // Expanded(child: _dataBody()),
            Padding(
                padding: EdgeInsets.only(left: 40.0,right: 40.0,top: 20.0,bottom: 20.0),
                child:SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    child: ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                        overlayColor: MaterialStateProperty.all<Color>(Colors.red),
                      ),
                      child: Text('Login',style: TextStyle(fontSize: 40,color: Colors.black),),
                      onPressed: (){
                        _loginUser();
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

