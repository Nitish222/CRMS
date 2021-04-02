import 'package:flutter/material.dart';
import 'package:myapp/screens/Login.dart';
import 'package:myapp/screens/Register.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.grey,
      ),
      home:DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Container(child: Row(
                children: [
                  Icon(Icons.app_registration),
                  Text('Login'),
                ],
            ) ),),
                Tab(icon: Container(child: Row(
                  children: [
                    Icon(Icons.app_registration),
                    Text('Register',textAlign: TextAlign.center,),
                  ],
                )
                ),
                ),
              ],
            ),
            title: Text('Criminal Record Management System'),
          ),
          body: TabBarView(
            children: [
              Login(),
              Register(),
            ],
          ),
        ),
      )
    );
  }
}


