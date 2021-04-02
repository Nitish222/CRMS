
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeReg extends StatefulWidget{
  @override
  _register_state createState() => _register_state();

}

class _register_state extends State<HomeReg>{
  Image img;
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
        body: Column(
            children: [
              Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: Form(child: TextField(
                    decoration: InputDecoration(
                      labelText: 'First Name',
                      labelStyle: TextStyle(fontSize: 40,),
                    ),
                  )),
                )
              ],
            ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    child: Form(child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Last Name',
                        labelStyle: TextStyle(fontSize: 40,),
                      ),
                    )),
                  )
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    child: Form(child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Officer ID',
                        labelStyle: TextStyle(fontSize: 40,),
                      ),
                    )),
                  )
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    child: Form(child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Rank',
                        labelStyle: TextStyle(fontSize: 40,),
                      ),
                    )),
                  )
                ],
              ),
              Row(
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      child: ElevatedButton(
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                          overlayColor: MaterialStateProperty.all<Color>(Colors.red),
                        ),
                        child: Text('Register',style: TextStyle(fontSize: 40,color: Colors.black),),
                        onPressed: (){
                          final snackBar = SnackBar(
                            content: Text('Loading...'),
                            action: SnackBarAction(
                              label: 'Undo',
                              onPressed: () {
                                // Some code to undo the change.
                              },
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                      )
                  )
                ],
              )
            ]
        )
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}