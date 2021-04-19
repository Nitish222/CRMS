import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Services/CaseServices/Evidence.dart';
import 'package:myapp/Services/CaseServices/EvidenceAPI.dart';
import 'package:myapp/Services/EvidenceCategoryServices/Item.dart';
import 'package:myapp/Services/EvidenceCategoryServices/ItemAPI.dart';

class CaseEvidenceDataModel extends StatefulWidget{
  CaseEvidenceDataModel():super();
  final String title = 'Add Evidence';
  @override
  _DataModel_State createState()=>_DataModel_State();

}


class _DataModel_State extends State<CaseEvidenceDataModel>{
  List<Evidence> _evidence;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isUpdating;
  String _titleProgress;
  TextEditingController _EvidenceDesscriptionController;
  TextEditingController _itemQuantityController;
  TextEditingController _categoryIDController;
  String categoryId;
  @override
  void initState(){
    super.initState();
    //for users
    _evidence = [];

    _titleProgress = widget.title;
    _EvidenceDesscriptionController = TextEditingController();
    _itemQuantityController = TextEditingController();
    _categoryIDController = TextEditingController();
  }
  _updateEvidence(Evidence category){
    setState(() {
      _isUpdating = true;
    });
    _showProgress('Updating item....');
    EvidenceAPI.updateEvidence(category.evidence_id.toString(),_categoryIDController.text,_EvidenceDesscriptionController.text, _itemQuantityController.text).then((result){
      if("success" == result){
        _getAllEvidence(); //Refresh the list after update
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
  _deleteEvidence(Evidence evidence){
    _showProgress('Deleting Item....');
    //String itemid = items.item_id.toString();
    EvidenceAPI.deleteEvidence(evidence.evidence_id.toString()).then((result){
      if("success" == result){
        _getAllEvidence(); //Refresh after delete...
      }
    });
  }

  _addEvidence(){
    _showProgress('Adding Evidence...');
    EvidenceAPI.addEvidence(_categoryIDController.text,_EvidenceDesscriptionController.text,_itemQuantityController.text).then((result){
      if("success"==result){
        _getAllEvidence(); //Refresh the list
        _clearValues();
      }
    });
  }
  _getAllEvidence(){
    _showProgress('Loading Items...');
    EvidenceAPI.getEvidence().then((items){
      setState(() {
        _evidence = items;
      });
      _showProgress(widget.title);
      print("Length ${items.length}");
    });
  }


  _clearValues(){
    _EvidenceDesscriptionController.text = '';
    _itemQuantityController.text = '';
    _categoryIDController.text = '';
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
          DataColumn(label: Text('View')),
        ],

        rows: _evidence.map((category)=> DataRow(
            cells: [
              DataCell(Text(category.evidence_id.toString())),
              DataCell(Text(category.category_id.toString())),
              DataCell(Text(category.item_description.toString())),
              DataCell(Text(category.item_quantity.toString())),
              DataCell(ElevatedButton(child: Text('UPDATE'),onPressed: (){
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
                                        height: 60,
                                        child: new TextFormField(
                                          controller: _EvidenceDesscriptionController,
                                          decoration: const InputDecoration(
                                              labelText: 'New Evidence Description',
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
                                          controller: _itemQuantityController,
                                          decoration: const InputDecoration(
                                              labelText: 'New item quantity',
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
                                              _updateEvidence(category);
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
              ),
              DataCell(ElevatedButton(child: Text('DELETE'),onPressed: (){ _deleteEvidence(category);},)),
              DataCell(ElevatedButton(child: Text('View Evidence'),onPressed: (){
                showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                          elevation: 16,
                          child: Container(
                            height: 400.0,
                            width: 360.0,
                            child: Image(image: NetworkImage('https://th.bing.com/th/id/OIP.-Ay_E1r5aLROXrFo9kBpEgHaC0?pid=ImgDet&rs=1'),)
                          )
                      );
                    });
                },)),
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
          automaticallyImplyLeading: false,
          title: Text(_titleProgress),
          actions: <Widget>[
            ElevatedButton(onPressed: (){
              showDialog(
                  context: context,
                  builder: (context)
                  {
                    return Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                        elevation: 16,
                        child: Container(
                          height: 800.0,
                          width: 600.0,
                          child: ListView(
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: SizedBox(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width,
                                      height: 60,
                                      child: new TextFormField(
                                        controller: _EvidenceDesscriptionController,
                                        decoration: const InputDecoration(
                                            labelText: 'Evidence Description',
                                            icon: const Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 15.0),
                                                child: const Icon(
                                                    Icons.account_balance_rounded))),
                                      ),
                                    )),
                                Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: SizedBox(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width,
                                      height: 60,
                                      child: new TextFormField(
                                        controller: _itemQuantityController,
                                        decoration: const InputDecoration(
                                            labelText: 'Evidence Quantity',
                                            icon: const Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 15.0),
                                                child: const Icon(
                                                    Icons.account_balance_rounded))),
                                      ),
                                    )),Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: SizedBox(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width,
                                      height: 60,
                                      child: new TextFormField(
                                        controller: _categoryIDController,
                                        decoration: const InputDecoration(
                                            labelText: 'Category ID',
                                            icon: const Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 15.0),
                                                child: const Icon(
                                                    Icons.account_balance_rounded))),
                                      ),
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(left: 40.0,
                                        right: 40.0,
                                        top: 20.0,
                                        bottom: 20.0),
                                    child: SizedBox(
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width,
                                        height: 80,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty
                                                .all<Color>(Colors.green),
                                            overlayColor: MaterialStateProperty.all<
                                                Color>(Colors.red),
                                          ),
                                          child: Text('Submit', style: TextStyle(
                                              fontSize: 40, color: Colors.black),),
                                          onPressed: () {
                                            _addEvidence();
                                          },
                                        )
                                    )
                                ),
                              ]
                          ),
                        )
                    );
                  }
              );
            }, child: Text('Add Evidence')),
            IconButton(icon: Icon(Icons.refresh),
                onPressed: (){
                  _getAllEvidence();
                }
            ),
          ],
        ),
        body: _dataBody(),
    );
  }

}